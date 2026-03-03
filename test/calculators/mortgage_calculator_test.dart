import 'package:conversion_kit/src/calculators/mortgage_calculator.dart';
import 'package:conversion_kit/src/models/mortgage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MortgageCalculator', () {
    late MortgageCalculator calculator;

    setUp(() {
      calculator = MortgageCalculator();
    });

    group('等额本息', () {
      test('计算 100 万贷款 30 年', () {
        final result = calculator.calculate(
          principal: 1000000,
          annualRate: 0.049,
          years: 30,
          type: MortgageType.equalPayment,
        );

        expect(result.monthlyPayment, greaterThan(0));
        expect(result.totalPayment, greaterThan(1000000));
        expect(result.totalInterest, greaterThan(0));
        expect(result.schedule.length, 360); // 30 年 = 360 个月

        // 验证月供大致正确（约 5307 元）
        expect(result.monthlyPayment, closeTo(5307, 10));
      });

      test('还款计划表正确', () {
        final result = calculator.calculate(
          principal: 1000000,
          annualRate: 0.049,
          years: 30,
          type: MortgageType.equalPayment,
        );

        // 验证第一期
        final firstMonth = result.schedule.first;
        expect(firstMonth.month, 1);
        expect(firstMonth.payment, closeTo(result.monthlyPayment, 0.01));
        expect(firstMonth.remainingPrincipal, lessThan(1000000));

        // 验证最后一期
        final lastMonth = result.schedule.last;
        expect(lastMonth.month, 360);
        expect(lastMonth.remainingPrincipal, closeTo(0, 0.01));
      });

      test('利率为 0 时正确计算', () {
        final result = calculator.calculate(
          principal: 1000000,
          annualRate: 0,
          years: 30,
          type: MortgageType.equalPayment,
        );

        // 无利息时，月供 = 本金 / 月数
        expect(result.monthlyPayment, closeTo(1000000 / 360, 0.01));
        expect(result.totalInterest, closeTo(0, 0.01));
      });
    });

    group('等额本金', () {
      test('计算 100 万贷款 30 年', () {
        final result = calculator.calculate(
          principal: 1000000,
          annualRate: 0.049,
          years: 30,
          type: MortgageType.equalPrincipal,
        );

        expect(result.monthlyPayment, greaterThan(0));
        expect(result.totalPayment, greaterThan(1000000));
        expect(result.totalInterest, greaterThan(0));
        expect(result.schedule.length, 360);

        // 首月月供应该高于等额本息
        expect(result.monthlyPayment, greaterThan(5307));
      });

      test('月供递减', () {
        final result = calculator.calculate(
          principal: 1000000,
          annualRate: 0.049,
          years: 30,
          type: MortgageType.equalPrincipal,
        );

        // 验证月供递减
        for (var i = 1; i < result.schedule.length; i++) {
          expect(
            result.schedule[i].payment,
            lessThan(result.schedule[i - 1].payment),
          );
        }
      });

      test('每月本金相同', () {
        final result = calculator.calculate(
          principal: 1000000,
          annualRate: 0.049,
          years: 30,
          type: MortgageType.equalPrincipal,
        );

        const expectedPrincipal = 1000000 / 360;

        for (final payment in result.schedule) {
          expect(payment.principal, closeTo(expectedPrincipal, 0.01));
        }
      });
    });

    group('提前还款', () {
      test('等额本息提前还款', () {
        final result = calculator.calculatePrepayment(
          principal: 1000000,
          annualRate: 0.049,
          years: 30,
          paidMonths: 60, // 已还 5 年
          prepaymentAmount: 200000, // 提前还 20 万
          type: MortgageType.equalPayment,
        );

        expect(result.savedInterest, greaterThan(0));
        expect(result.newMonthlyPayment, greaterThan(0));
        expect(result.newTotalPayment, lessThan(1000000 + 910000));
      });

      test('等额本金提前还款', () {
        final result = calculator.calculatePrepayment(
          principal: 1000000,
          annualRate: 0.049,
          years: 30,
          paidMonths: 60,
          prepaymentAmount: 200000,
          type: MortgageType.equalPrincipal,
        );

        expect(result.savedInterest, greaterThan(0));
        expect(result.newMonthlyPayment, greaterThan(0));
      });
    });

    group('组合贷款', () {
      test('计算商业贷款 + 公积金贷款', () {
        final result = calculator.calculateCombination(
          commercialPrincipal: 700000,
          commercialRate: 0.049,
          providentPrincipal: 300000,
          providentRate: 0.0325,
          years: 30,
          type: MortgageType.equalPayment,
        );

        expect(result.monthlyPayment, greaterThan(0));
        expect(result.totalPayment, greaterThan(1000000));
        expect(result.totalInterest, greaterThan(0));
        expect(result.schedule.length, 360);

        // 组合贷款的利息应该低于全部商业贷款
        final allCommercial = calculator.calculate(
          principal: 1000000,
          annualRate: 0.049,
          years: 30,
          type: MortgageType.equalPayment,
        );

        expect(result.totalInterest, lessThan(allCommercial.totalInterest));
      });
    });

    group('格式化金额', () {
      test('格式化普通金额', () {
        final formatted = calculator.formatAmount(1234567.89);
        expect(formatted, '1,234,567.89');
      });

      test('格式化小额金额', () {
        final formatted = calculator.formatAmount(999.99);
        expect(formatted, '999.99');
      });

      test('自定义小数位数', () {
        final formatted = calculator.formatAmount(1234.5678, decimals: 4);
        expect(formatted, '1,234.5678');
      });
    });
  });
}
