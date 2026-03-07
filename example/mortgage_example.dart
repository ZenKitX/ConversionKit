import 'package:conversion_kit/conversion_kit.dart';

/// 房贷计算器示例
///
/// 演示如何使用 MortgageCalculator 进行房贷计算。
void main() {
  print('=== ConversionKit 房贷计算器示例 ===\n');

  final calculator = MortgageCalculator();

  // 示例 1: 等额本息
  print('示例 1: 等额本息');
  print('贷款 100 万，年利率 4.9%，30 年');
  final equalPayment = calculator.calculate(
    principal: 1000000,
    annualRate: 0.049,
    years: 30,
    type: MortgageType.equalPayment,
  );

  print('月供: ${calculator.formatAmount(equalPayment.monthlyPayment)} 元');
  print('还款总额: ${calculator.formatAmount(equalPayment.totalPayment)} 元');
  print('利息总额: ${calculator.formatAmount(equalPayment.totalInterest)} 元');
  print('');

  // 示例 2: 等额本金
  print('示例 2: 等额本金');
  print('贷款 100 万，年利率 4.9%，30 年');
  final equalPrincipal = calculator.calculate(
    principal: 1000000,
    annualRate: 0.049,
    years: 30,
    type: MortgageType.equalPrincipal,
  );

  print('首月月供: ${calculator.formatAmount(equalPrincipal.monthlyPayment)} 元');
  print('还款总额: ${calculator.formatAmount(equalPrincipal.totalPayment)} 元');
  print('利息总额: ${calculator.formatAmount(equalPrincipal.totalInterest)} 元');
  print('');

  // 示例 3: 对比两种还款方式
  print('示例 3: 对比两种还款方式');
  final interestDiff =
      equalPayment.totalInterest - equalPrincipal.totalInterest;
  print('等额本息比等额本金多付利息: ${calculator.formatAmount(interestDiff)} 元');
  print('');

  // 示例 4: 还款计划表（前 12 个月）
  print('示例 4: 等额本息还款计划表（前 12 个月）');
  print('期数\t月供\t\t本金\t\t利息\t\t剩余本金');
  for (var i = 0; i < 12; i++) {
    final payment = equalPayment.schedule[i];
    print(
      '${payment.month}\t'
      '${calculator.formatAmount(payment.payment, decimals: 0)}\t'
      '${calculator.formatAmount(payment.principal, decimals: 0)}\t'
      '${calculator.formatAmount(payment.interest, decimals: 0)}\t'
      '${calculator.formatAmount(payment.remainingPrincipal, decimals: 0)}',
    );
  }
  print('');

  // 示例 5: 提前还款
  print('示例 5: 提前还款');
  print('已还 5 年（60 期），提前还款 20 万');
  final prepayment = calculator.calculatePrepayment(
    principal: 1000000,
    annualRate: 0.049,
    years: 30,
    paidMonths: 60,
    prepaymentAmount: 200000,
    type: MortgageType.equalPayment,
  );

  print('节省利息: ${calculator.formatAmount(prepayment.savedInterest)} 元');
  print('新月供: ${calculator.formatAmount(prepayment.newMonthlyPayment)} 元');
  print('新还款总额: ${calculator.formatAmount(prepayment.newTotalPayment)} 元');
  print('');

  // 示例 6: 组合贷款
  print('示例 6: 组合贷款');
  print('商业贷款 70 万（4.9%）+ 公积金贷款 30 万（3.25%），30 年');
  final combination = calculator.calculateCombination(
    commercialPrincipal: 700000,
    commercialRate: 0.049,
    providentPrincipal: 300000,
    providentRate: 0.0325,
    years: 30,
    type: MortgageType.equalPayment,
  );

  print('月供: ${calculator.formatAmount(combination.monthlyPayment)} 元');
  print('还款总额: ${calculator.formatAmount(combination.totalPayment)} 元');
  print('利息总额: ${calculator.formatAmount(combination.totalInterest)} 元');
  print('');

  // 示例 7: 实际应用场景
  print('示例 7: 实际应用场景 - 购房决策');
  print('房价 200 万，首付 60 万，贷款 140 万');
  print('');

  // 方案 1: 全部商业贷款
  final plan1 = calculator.calculate(
    principal: 1400000,
    annualRate: 0.049,
    years: 30,
    type: MortgageType.equalPayment,
  );

  print('方案 1: 全部商业贷款（4.9%）');
  print('  月供: ${calculator.formatAmount(plan1.monthlyPayment)} 元');
  print('  利息总额: ${calculator.formatAmount(plan1.totalInterest)} 元');
  print('');

  // 方案 2: 组合贷款
  final plan2 = calculator.calculateCombination(
    commercialPrincipal: 1000000,
    commercialRate: 0.049,
    providentPrincipal: 400000,
    providentRate: 0.0325,
    years: 30,
    type: MortgageType.equalPayment,
  );

  print('方案 2: 组合贷款（商业 100 万 + 公积金 40 万）');
  print('  月供: ${calculator.formatAmount(plan2.monthlyPayment)} 元');
  print('  利息总额: ${calculator.formatAmount(plan2.totalInterest)} 元');
  print('');

  final saved = plan1.totalInterest - plan2.totalInterest;
  print('方案 2 比方案 1 节省利息: ${calculator.formatAmount(saved)} 元');
}
