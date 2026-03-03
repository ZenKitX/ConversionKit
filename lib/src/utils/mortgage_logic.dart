import 'dart:math';

import '../models/mortgage.dart';

/// 房贷计算逻辑
///
/// 提供房贷相关的计算方法。
class MortgageLogic {
  /// 计算等额本息
  ///
  /// 每月还款金额相同，包含本金和利息。
  ///
  /// 参数:
  /// - [principal]: 贷款本金
  /// - [annualRate]: 年利率（如 0.049 表示 4.9%）
  /// - [months]: 贷款月数
  ///
  /// 返回月供金额。
  ///
  /// 公式: M = P * r * (1 + r)^n / [(1 + r)^n - 1]
  /// - M: 月供
  /// - P: 本金
  /// - r: 月利率
  /// - n: 还款月数
  static double calculateEqualPayment({
    required double principal,
    required double annualRate,
    required int months,
  }) {
    if (principal <= 0 || annualRate < 0 || months <= 0) {
      return 0;
    }

    // 月利率
    final monthlyRate = annualRate / 12;

    // 如果利率为 0，直接返回本金除以月数
    if (monthlyRate == 0) {
      return principal / months;
    }

    // 计算月供
    final temp = pow(1 + monthlyRate, months);
    final monthlyPayment = principal * monthlyRate * temp / (temp - 1);

    return monthlyPayment;
  }

  /// 计算等额本金首月月供
  ///
  /// 每月还款本金相同，利息递减。
  ///
  /// 参数:
  /// - [principal]: 贷款本金
  /// - [annualRate]: 年利率
  /// - [months]: 贷款月数
  ///
  /// 返回首月月供金额。
  static double calculateEqualPrincipalFirstMonth({
    required double principal,
    required double annualRate,
    required int months,
  }) {
    if (principal <= 0 || annualRate < 0 || months <= 0) {
      return 0;
    }

    final monthlyRate = annualRate / 12;
    final monthlyPrincipal = principal / months;
    final firstMonthInterest = principal * monthlyRate;

    return monthlyPrincipal + firstMonthInterest;
  }

  /// 生成等额本息还款计划
  ///
  /// 参数:
  /// - [principal]: 贷款本金
  /// - [annualRate]: 年利率
  /// - [months]: 贷款月数
  ///
  /// 返回完整的还款计划表。
  static List<MonthlyPayment> generateEqualPaymentSchedule({
    required double principal,
    required double annualRate,
    required int months,
  }) {
    final schedule = <MonthlyPayment>[];
    final monthlyRate = annualRate / 12;
    final monthlyPayment = calculateEqualPayment(
      principal: principal,
      annualRate: annualRate,
      months: months,
    );

    var remainingPrincipal = principal;

    for (var i = 1; i <= months; i++) {
      final interest = remainingPrincipal * monthlyRate;
      final principalPayment = monthlyPayment - interest;
      remainingPrincipal -= principalPayment;

      // 最后一期可能有微小误差，调整为 0
      if (i == months) {
        remainingPrincipal = 0;
      }

      schedule.add(
        MonthlyPayment(
          month: i,
          payment: monthlyPayment,
          principal: principalPayment,
          interest: interest,
          remainingPrincipal: remainingPrincipal,
        ),
      );
    }

    return schedule;
  }

  /// 生成等额本金还款计划
  ///
  /// 参数:
  /// - [principal]: 贷款本金
  /// - [annualRate]: 年利率
  /// - [months]: 贷款月数
  ///
  /// 返回完整的还款计划表。
  static List<MonthlyPayment> generateEqualPrincipalSchedule({
    required double principal,
    required double annualRate,
    required int months,
  }) {
    final schedule = <MonthlyPayment>[];
    final monthlyRate = annualRate / 12;
    final monthlyPrincipal = principal / months;

    var remainingPrincipal = principal;

    for (var i = 1; i <= months; i++) {
      final interest = remainingPrincipal * monthlyRate;
      final payment = monthlyPrincipal + interest;
      remainingPrincipal -= monthlyPrincipal;

      // 最后一期可能有微小误差，调整为 0
      if (i == months) {
        remainingPrincipal = 0;
      }

      schedule.add(
        MonthlyPayment(
          month: i,
          payment: payment,
          principal: monthlyPrincipal,
          interest: interest,
          remainingPrincipal: remainingPrincipal,
        ),
      );
    }

    return schedule;
  }

  /// 计算总利息
  ///
  /// 参数:
  /// - [schedule]: 还款计划表
  ///
  /// 返回利息总额。
  static double calculateTotalInterest(List<MonthlyPayment> schedule) {
    return schedule.fold<double>(0, (sum, payment) => sum + payment.interest);
  }

  /// 计算还款总额
  ///
  /// 参数:
  /// - [schedule]: 还款计划表
  ///
  /// 返回还款总额。
  static double calculateTotalPayment(List<MonthlyPayment> schedule) {
    return schedule.fold<double>(0, (sum, payment) => sum + payment.payment);
  }

  /// 计算提前还款
  ///
  /// 参数:
  /// - [principal]: 原贷款本金
  /// - [annualRate]: 年利率
  /// - [totalMonths]: 总贷款月数
  /// - [paidMonths]: 已还月数
  /// - [prepaymentAmount]: 提前还款金额
  /// - [mortgageType]: 房贷类型
  ///
  /// 返回提前还款结果。
  static PrepaymentResult calculatePrepayment({
    required double principal,
    required double annualRate,
    required int totalMonths,
    required int paidMonths,
    required double prepaymentAmount,
    required MortgageType mortgageType,
  }) {
    // 生成原还款计划
    final originalSchedule = mortgageType == MortgageType.equalPayment
        ? generateEqualPaymentSchedule(
            principal: principal,
            annualRate: annualRate,
            months: totalMonths,
          )
        : generateEqualPrincipalSchedule(
            principal: principal,
            annualRate: annualRate,
            months: totalMonths,
          );

    // 计算原总利息
    final originalTotalInterest = calculateTotalInterest(originalSchedule);

    // 获取当前剩余本金
    final remainingPrincipal = paidMonths > 0
        ? originalSchedule[paidMonths - 1].remainingPrincipal
        : principal;

    // 提前还款后的剩余本金
    final newPrincipal = remainingPrincipal - prepaymentAmount;

    // 剩余月数
    final remainingMonths = totalMonths - paidMonths;

    // 生成新的还款计划
    final newSchedule = mortgageType == MortgageType.equalPayment
        ? generateEqualPaymentSchedule(
            principal: newPrincipal,
            annualRate: annualRate,
            months: remainingMonths,
          )
        : generateEqualPrincipalSchedule(
            principal: newPrincipal,
            annualRate: annualRate,
            months: remainingMonths,
          );

    // 计算新的总利息（已还利息 + 剩余利息）
    final paidInterest = paidMonths > 0
        ? originalSchedule
            .take(paidMonths)
            .fold<double>(0, (sum, payment) => sum + payment.interest)
        : 0.0;
    final newTotalInterest = paidInterest + calculateTotalInterest(newSchedule);

    // 计算节省的利息
    final savedInterest = originalTotalInterest - newTotalInterest;

    // 新的月供
    final newMonthlyPayment =
        newSchedule.isNotEmpty ? newSchedule.first.payment : 0.0;

    // 新的还款总额
    final newTotalPayment = principal + newTotalInterest;

    return PrepaymentResult(
      savedInterest: savedInterest,
      newMonthlyPayment: newMonthlyPayment,
      newTotalPayment: newTotalPayment,
      newTotalInterest: newTotalInterest,
      reducedMonths: 0, // 保持还款期限不变
    );
  }
}
