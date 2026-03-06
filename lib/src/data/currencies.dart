import '../models/currency.dart';

/// 货币数据定义
///
/// 包含常用的货币信息，遵循 ISO 4217 标准。
///
/// ## 使用示例
///
/// ```dart
/// // 获取所有货币
/// final currencies = CurrencyData.currencies;
///
/// // 查找特定货币
/// final usd = CurrencyData.findCurrencyByCode('USD');
/// ```
class CurrencyData {
  /// 常用货币列表
  ///
  /// 包含主流货币：
  /// - 美元 (USD)
  /// - 欧元 (EUR)
  /// - 人民币 (CNY)
  /// - 日元 (JPY)
  /// - 英镑 (GBP)
  /// - 澳元 (AUD)
  /// - 加元 (CAD)
  /// - 瑞士法郎 (CHF)
  /// - 港币 (HKD)
  /// - 新加坡元 (SGD)
  /// - 韩元 (KRW)
  /// - 新台币 (TWD)
  static const currencies = [
    Currency(code: 'USD', name: '美元', symbol: '\$'),
    Currency(code: 'EUR', name: '欧元', symbol: '€'),
    Currency(code: 'CNY', name: '人民币', symbol: '¥'),
    Currency(code: 'JPY', name: '日元', symbol: '¥'),
    Currency(code: 'GBP', name: '英镑', symbol: '£'),
    Currency(code: 'AUD', name: '澳元', symbol: 'A\$'),
    Currency(code: 'CAD', name: '加元', symbol: 'C\$'),
    Currency(code: 'CHF', name: '瑞士法郎', symbol: 'CHF'),
    Currency(code: 'HKD', name: '港币', symbol: 'HK\$'),
    Currency(code: 'SGD', name: '新加坡元', symbol: 'S\$'),
    Currency(code: 'KRW', name: '韩元', symbol: '₩'),
    Currency(code: 'TWD', name: '新台币', symbol: 'NT\$'),
  ];

  /// 根据货币代码查找货币
  ///
  /// 参数:
  /// - [code]: 货币代码（ISO 4217）
  ///
  /// 返回找到的货币，如果不存在返回 null。
  static Currency? findCurrencyByCode(String code) {
    try {
      return currencies.firstWhere(
        (currency) => currency.code.toUpperCase() == code.toUpperCase(),
      );
    } catch (e) {
      return null;
    }
  }
}
