import '../models/mortgage.dart';
import '../utils/mortgage_logic.dart';

/// 房贷计算器
///
/// 提供房贷计算功能，包括等额本息、等额本金和提前还款。
///
/// ## 使用示例
///
/// ```dart
/// final calculator = MortgageCalculator();
///
/// // 计算等额本息
/// final result = calculator.calculate(
///   principal: 1000000,
///   annualRate: 0.049,
///   years: 30,
///   type: MortgageType.equalPayment,
/// );
///
/// print('月供: ${result.monthlyPayment}');
/// print('总利息: ${result.totalInterest}');
/// ```
class MortgageCalculator {
  /// 计算房贷
  ///
  /// 参数:
  /// - [principal]: 贷款本金
  /// - [annualRate]: 年利率（如 0.049 表示 4.9%）
  /// - [years]: 贷款年数
  /// - [type]: 房贷类型（等额本息或等额本金）
  ///
  /// 返回房贷计算结果。
  MortgageResult calculate({
    required double principal,
    required double annualRate,
    required int years,
    required MortgageType type,
  }) {
    final months = years * 12;

    // 生成还款计划
    final schedule = type == MortgageType.equalPayment
        ? MortgageLogic.generateEqualPaymentSchedule(
            principal: principal,
            annualRate: annualRate,
            months: months,
          )
        : MortgageLogic.generateEqualPrincipalSchedule(
            principal: principal,
            annualRate: annualRate,
            months: months,
          );

    // 计算总额
    final totalInterest = MortgageLogic.calculateTotalInterest(schedule);
    final totalPayment = MortgageLogic.calculateTotalPayment(schedule);

    // 月供（等额本息固定，等额本金取首月）
    final monthlyPayment = schedule.isNotEmpty ? schedule.first.payment : 0.0;

    return MortgageResult(
      monthlyPayment: monthlyPayment,
      totalPayment: totalPayment,
      totalInterest: totalInterest,
      schedule: schedule,
    );
  }

  /// 计算提前还款
  ///
  /// 参数:
  /// - [principal]: 原贷款本金
  /// - [annualRate]: 年利率
  /// - [years]: 总贷款年数
  /// - [paidMonths]: 已还月数
  /// - [prepaymentAmount]: 提前还款金额
  /// - [type]: 房贷类型
  ///
  /// 返回提前还款结果。
  PrepaymentResult calculatePrepayment({
    required double principal,
    required double annualRate,
    required int years,
    required int paidMonths,
    required double prepaymentAmount,
    required MortgageType type,
  }) {
    final totalMonths = years * 12;

    return MortgageLogic.calculatePrepayment(
      principal: principal,
      annualRate: annualRate,
      totalMonths: totalMonths,
      paidMonths: paidMonths,
      prepaymentAmount: prepaymentAmount,
      mortgageType: type,
    );
  }

  /// 计算组合贷款
  ///
  /// 同时计算商业贷款和公积金贷款。
  ///
  /// 参数:
  /// - [commercialPrincipal]: 商业贷款本金
  /// - [commercialRate]: 商业贷款年利率
  /// - [providentPrincipal]: 公积金贷款本金
  /// - [providentRate]: 公积金贷款年利率
  /// - [years]: 贷款年数
  /// - [type]: 房贷类型
  ///
  /// 返回组合贷款的总计算结果。
  MortgageResult calculateCombination({
    required double commercialPrincipal,
    required double commercialRate,
    required double providentPrincipal,
    required double providentRate,
    required int years,
    required MortgageType type,
  }) {
    // 计算商业贷款
    final commercial = calculate(
      principal: commercialPrincipal,
      annualRate: commercialRate,
      years: years,
      type: type,
    );

    // 计算公积金贷款
    final provident = calculate(
      principal: providentPrincipal,
      annualRate: providentRate,
      years: years,
      type: type,
    );

    // 合并结果
    final totalMonthlyPayment = commercial.monthlyPayment + provident.monthlyPayment;
    final totalPayment = commercial.totalPayment + provident.totalPayment;
    final totalInterest = commercial.totalInterest + provident.totalInterest;

    // 合并还款计划（按月合并）
    final schedule = <MonthlyPayment>[];
    for (var i = 0; i < commercial.schedule.length; i++) {
      final c = commercial.schedule[i];
      final p = provident.schedule[i];

      schedule.add(
        MonthlyPayment(
          month: c.month,
          payment: c.payment + p.payment,
          principal: c.principal + p.principal,
          interest: c.interest + p.interest,
          remainingPrincipal: c.remainingPrincipal + p.remainingPrincipal,
        ),
      );
    }

    return MortgageResult(
      monthlyPayment: totalMonthlyPayment,
      totalPayment: totalPayment,
      totalInterest: totalInterest,
      schedule: schedule,
    );
  }

  /// 格式化金额
  ///
  /// 参数:
  /// - [amount]: 金额
  /// - [decimals]: 小数位数，默认为 2
  ///
  /// 返回格式化后的字符串（带千分位）。
  String formatAmount(double amount, {int decimals = 2}) {
    final formatted = amount.toStringAsFixed(decimals);
    final parts = formatted.split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : '';

    final buffer = StringBuffer();
    var count = 0;

    for (var i = integerPart.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(integerPart[i]);
      count++;
    }

    final result = buffer.toString().split('').reversed.join();

    return decimalPart.isEmpty ? result : '$result.$decimalPart';
  }
}
