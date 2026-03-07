import 'package:conversion_kit/conversion_kit.dart';

/// ConversionKit 综合示例
///
/// 展示单位换算、汇率转换、房贷计算的综合应用场景。
void main() async {
  print('╔════════════════════════════════════════════════════════════╗');
  print('║         ConversionKit v0.2.0 综合功能演示                 ║');
  print('╚════════════════════════════════════════════════════════════╝\n');

  // ============================================================
  // 场景 1: 海外购房计算
  // ============================================================
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('场景 1: 海外购房计算');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

  // 房产信息
  const housePriceUsd = 500000.0; // 美国房价 50 万美元
  const downPaymentRatio = 0.2; // 首付 20%
  const loanYears = 30;
  const annualRate = 0.065; // 年利率 6.5%

  print('房产信息:');
  print('  房价: \$${housePriceUsd.toStringAsFixed(0)} USD');
  print('  首付比例: ${(downPaymentRatio * 100).toStringAsFixed(0)}%');
  print('  贷款年限: $loanYears 年');
  print('  年利率: ${(annualRate * 100).toStringAsFixed(2)}%\n');

  // 1. 汇率转换 - 计算人民币价格
  final currencyConverter = CurrencyConverter();
  final housePriceCny = await currencyConverter.convert(
    value: housePriceUsd,
    from: 'USD',
    to: 'CNY',
  );

  print('价格换算:');
  print(
    '  美元价格: \$${currencyConverter.formatAmount(value: housePriceUsd, currencyCode: 'USD')} USD',
  );
  if (housePriceCny != null) {
    print(
      '  人民币价格: ¥${currencyConverter.formatAmount(value: housePriceCny, currencyCode: 'CNY')} CNY\n',
    );
  }

  // 2. 房贷计算
  final mortgageCalculator = MortgageCalculator();
  final loanAmount = housePriceUsd * (1 - downPaymentRatio);
  final downPayment = housePriceUsd * downPaymentRatio;

  final mortgageResult = mortgageCalculator.calculate(
    principal: loanAmount,
    annualRate: annualRate,
    years: loanYears,
    type: MortgageType.equalPayment,
  );

  print('贷款计算（等额本息）:');
  print('  贷款金额: \$${mortgageCalculator.formatAmount(loanAmount)} USD');
  print('  首付金额: \$${mortgageCalculator.formatAmount(downPayment)} USD');
  print(
    '  月供: \$${mortgageCalculator.formatAmount(mortgageResult.monthlyPayment)} USD',
  );
  print(
    '  还款总额: \$${mortgageCalculator.formatAmount(mortgageResult.totalPayment)} USD',
  );
  print(
    '  利息总额: \$${mortgageCalculator.formatAmount(mortgageResult.totalInterest)} USD\n',
  );

  // 3. 月供换算成人民币
  final monthlyPaymentCny = await currencyConverter.convert(
    value: mortgageResult.monthlyPayment,
    from: 'USD',
    to: 'CNY',
  );

  if (monthlyPaymentCny != null) {
    print(
      '月供（人民币）: ¥${currencyConverter.formatAmount(value: monthlyPaymentCny, currencyCode: 'CNY')} CNY\n',
    );
  }

  // ============================================================
  // 场景 2: 装修材料采购
  // ============================================================
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('场景 2: 装修材料采购');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

  final unitConverter = UnitConverter();

  // 房屋面积（美国使用平方英尺）
  const houseAreaSqft = 2000.0; // 2000 平方英尺

  // 转换为平方米
  final houseAreaSqm = unitConverter.convert(
    value: houseAreaSqft,
    categoryId: 'area',
    fromUnitId: 'square_foot',
    toUnitId: 'square_meter',
  );

  print('房屋面积:');
  print(
    '  ${houseAreaSqft.toStringAsFixed(0)} 平方英尺 = ${houseAreaSqm.toStringAsFixed(2)} 平方米\n',
  );

  // 地板材料计算（按平方米计价）
  const floorPricePerSqm = 200.0; // 每平方米 200 元
  final totalFloorCost = houseAreaSqm * floorPricePerSqm;

  print('地板材料:');
  print('  单价: ¥${floorPricePerSqm.toStringAsFixed(0)}/平方米');
  print(
    '  总价: ¥${currencyConverter.formatAmount(value: totalFloorCost, currencyCode: 'CNY')} CNY\n',
  );

  // 油漆用量计算（按加仑购买）
  const paintCoveragePerGallon = 400.0; // 每加仑覆盖 400 平方英尺
  final gallonsNeeded = (houseAreaSqft / paintCoveragePerGallon).ceilToDouble();

  print('油漆用量:');
  print('  需要: ${gallonsNeeded.toStringAsFixed(0)} 加仑\n');

  // ============================================================
  // 场景 3: 跨境电商价格对比
  // ============================================================
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('场景 3: 跨境电商价格对比');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

  // 商品价格（不同国家）
  const productPrices = {
    'USD': 299.99, // 美国
    'EUR': 279.99, // 欧洲
    'JPY': 39800.0, // 日本
    'GBP': 249.99, // 英国
  };

  print('商品价格对比:');
  for (final entry in productPrices.entries) {
    final currency = entry.key;
    final price = entry.value;
    final symbol = CurrencyData.findCurrencyByCode(currency)?.symbol ?? '';

    // 转换为人民币
    final priceCny = await currencyConverter.convert(
      value: price,
      from: currency,
      to: 'CNY',
    );

    if (priceCny != null) {
      print(
        '  $currency: $symbol${currencyConverter.formatAmount(value: price, currencyCode: currency)} '
        '≈ ¥${currencyConverter.formatAmount(value: priceCny, currencyCode: 'CNY')} CNY',
      );
    }
  }
  print('');

  // ============================================================
  // 场景 4: 国内购房对比
  // ============================================================
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('场景 4: 国内购房贷款方案对比');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

  const domesticHousePrice = 3000000.0; // 300 万
  const domesticLoanAmount = 2000000.0; // 贷款 200 万
  const domesticYears = 30;
  const commercialRate = 0.049; // 商业贷款 4.9%
  const providentRate = 0.0325; // 公积金贷款 3.25%

  print('房产信息:');
  print('  房价: ¥${mortgageCalculator.formatAmount(domesticHousePrice)} 元');
  print('  贷款: ¥${mortgageCalculator.formatAmount(domesticLoanAmount)} 元');
  print('  年限: $domesticYears 年\n');

  // 方案 1: 纯商业贷款 - 等额本息
  final plan1 = mortgageCalculator.calculate(
    principal: domesticLoanAmount,
    annualRate: commercialRate,
    years: domesticYears,
    type: MortgageType.equalPayment,
  );

  print('方案 1: 纯商业贷款 - 等额本息');
  print('  利率: ${(commercialRate * 100).toStringAsFixed(2)}%');
  print('  月供: ¥${mortgageCalculator.formatAmount(plan1.monthlyPayment)} 元');
  print('  利息总额: ¥${mortgageCalculator.formatAmount(plan1.totalInterest)} 元\n');

  // 方案 2: 纯商业贷款 - 等额本金
  final plan2 = mortgageCalculator.calculate(
    principal: domesticLoanAmount,
    annualRate: commercialRate,
    years: domesticYears,
    type: MortgageType.equalPrincipal,
  );

  print('方案 2: 纯商业贷款 - 等额本金');
  print('  利率: ${(commercialRate * 100).toStringAsFixed(2)}%');
  print('  首月月供: ¥${mortgageCalculator.formatAmount(plan2.monthlyPayment)} 元');
  print('  利息总额: ¥${mortgageCalculator.formatAmount(plan2.totalInterest)} 元');
  print(
    '  节省利息: ¥${mortgageCalculator.formatAmount(plan1.totalInterest - plan2.totalInterest)} 元\n',
  );

  // 方案 3: 组合贷款
  final plan3 = mortgageCalculator.calculateCombination(
    commercialPrincipal: 1200000, // 商业贷款 120 万
    commercialRate: commercialRate,
    providentPrincipal: 800000, // 公积金贷款 80 万
    providentRate: providentRate,
    years: domesticYears,
    type: MortgageType.equalPayment,
  );

  print('方案 3: 组合贷款（商业 120 万 + 公积金 80 万）');
  print('  商业利率: ${(commercialRate * 100).toStringAsFixed(2)}%');
  print('  公积金利率: ${(providentRate * 100).toStringAsFixed(2)}%');
  print('  月供: ¥${mortgageCalculator.formatAmount(plan3.monthlyPayment)} 元');
  print('  利息总额: ¥${mortgageCalculator.formatAmount(plan3.totalInterest)} 元');
  print(
    '  比方案 1 节省: ¥${mortgageCalculator.formatAmount(plan1.totalInterest - plan3.totalInterest)} 元\n',
  );

  // 推荐方案
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('推荐方案: 组合贷款');
  print('  理由: 利息最低，月供适中');
  print(
    '  相比纯商业贷款节省: ¥${mortgageCalculator.formatAmount(plan1.totalInterest - plan3.totalInterest)} 元',
  );
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

  print('✨ ConversionKit - 让换算更简单！');
}
