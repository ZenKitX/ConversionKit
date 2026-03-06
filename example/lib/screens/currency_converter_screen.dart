import 'package:flutter/material.dart';
import 'package:conversion_kit/conversion_kit.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final _converter = CurrencyConverter();
  final _inputController = TextEditingController(text: '100');
  
  String _fromCurrency = 'USD';
  String _toCurrency = 'CNY';
  String _result = '';
  bool _isLoading = false;

  final List<Currency> _currencies = CurrencyData.getAllCurrencies();

  @override
  void initState() {
    super.initState();
    _convert();
  }

  Future<void> _convert() async {
    final input = _inputController.text;
    if (input.isEmpty) {
      setState(() => _result = '');
      return;
    }

    final value = double.tryParse(input);
    if (value == null) {
      setState(() => _result = '请输入有效数字');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await _converter.convert(
        value: value,
        from: _fromCurrency,
        to: _toCurrency,
      );

      if (result != null) {
        final formatted = _converter.formatAmount(
          value: result,
          currencyCode: _toCurrency,
        );
        setState(() {
          _result = formatted;
          _isLoading = false;
        });
      } else {
        setState(() {
          _result = '转换失败';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _result = '错误: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('汇率换算'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('输入金额', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '请输入金额',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => _convert(),
            ),
            const SizedBox(height: 24),
            const Text('从', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _fromCurrency,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _currencies.map((currency) {
                return DropdownMenuItem(
                  value: currency.code,
                  child: Text('${currency.symbol} ${currency.name} (${currency.code})'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _fromCurrency = value!;
                  _convert();
                });
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: IconButton(
                icon: const Icon(Icons.swap_vert, size: 32),
                onPressed: () {
                  setState(() {
                    final temp = _fromCurrency;
                    _fromCurrency = _toCurrency;
                    _toCurrency = temp;
                    _convert();
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text('到', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _toCurrency,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _currencies.map((currency) {
                return DropdownMenuItem(
                  value: currency.code,
                  child: Text('${currency.symbol} ${currency.name} (${currency.code})'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _toCurrency = value!;
                  _convert();
                });
              },
            ),
            const SizedBox(height: 24),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '转换结果',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Text(
                            _result.isEmpty ? '等待输入...' : _result,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '汇率数据来自模拟 API，仅供演示使用',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
