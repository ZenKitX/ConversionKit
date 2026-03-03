/// 房贷类型
enum MortgageType {
  /// 等额本息
  equalPayment,

  /// 等额本金
  equalPrincipal,
}

/// 贷款类型
enum LoanType {
  /// 商业贷款
  commercial,

  /// 公积金贷款
  providentFund,

  /// 组合贷款
  combination,
}

/// 房贷计算结果
///
/// 包含贷款的详细计算结果。
class MortgageResult {
  /// 创建房贷计算结果
  const MortgageResult({
    required this.monthlyPayment,
    required this.totalPayment,
    required this.totalInterest,
    required this.schedule,
  });

  /// 月供金额
  final double monthlyPayment;

  /// 还款总额
  final double totalPayment;

  /// 利息总额
  final double totalInterest;

  /// 还款计划表
  final List<MonthlyPayment> schedule;

  @override
  String toString() {
    return 'MortgageResult(monthlyPayment: $monthlyPayment, '
        'totalPayment: $totalPayment, totalInterest: $totalInterest)';
  }
}

/// 月供详情
///
/// 表示某一期的还款详情。
class MonthlyPayment {
  /// 创建月供详情
  const MonthlyPayment({
    required this.month,
    required this.payment,
    required this.principal,
    required this.interest,
    required this.remainingPrincipal,
  });

  /// 期数
  final int month;

  /// 月供金额
  final double payment;

  /// 本金
  final double principal;

  /// 利息
  final double interest;

  /// 剩余本金
  final double remainingPrincipal;

  @override
  String toString() {
    return 'MonthlyPayment(month: $month, payment: $payment, '
        'principal: $principal, interest: $interest, '
        'remainingPrincipal: $remainingPrincipal)';
  }
}

/// 提前还款结果
///
/// 包含提前还款后的计算结果。
class PrepaymentResult {
  /// 创建提前还款结果
  const PrepaymentResult({
    required this.savedInterest,
    required this.newMonthlyPayment,
    required this.newTotalPayment,
    required this.newTotalInterest,
    required this.reducedMonths,
  });

  /// 节省的利息
  final double savedInterest;

  /// 新的月供金额
  final double newMonthlyPayment;

  /// 新的还款总额
  final double newTotalPayment;

  /// 新的利息总额
  final double newTotalInterest;

  /// 减少的月数
  final int reducedMonths;

  @override
  String toString() {
    return 'PrepaymentResult(savedInterest: $savedInterest, '
        'newMonthlyPayment: $newMonthlyPayment, '
        'reducedMonths: $reducedMonths)';
  }
}
