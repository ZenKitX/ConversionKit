import 'package:flutter/material.dart';
import 'package:conversion_kit/conversion_kit.dart';

class MortgageCalculatorScreen extends StatefulWidget {
  const MortgageCalculatorScreen({super.key});

  @override
  State<MortgageCalculatorScreen> createState() =>
      _MortgageCalculatorScreenState();
}

class _MortgageCalculatorScreenState extends State<MortgageCalculatorScreen> {
  final _calculator = MortgageCalculator();
  final _principalController = TextEditingController(text: '1000000');
  final _rateController = TextEditingController(text: '4.9');
  final _yearsController = TextEditingController(text: '30');

  MortgageType _mortgageType = MortgageType.equalPayment;
  MortgageResult? _result;

  @override
  void initState() {
    super.initState();
    _calculate();
  }

  void _calculate() {
    final principal = double.tryParse(_principalController.text);
    final rate = double.tryParse(_rateController.text);
    final years = int.tryParse(_yearsController.text);

    if (principal == null || rate == null || years == null) {
      setState(() => _result = null);
      return;
    }

    try {
      final result = _calculator.calculate(
        principal: principal,
        annualRate: rate / 100,
        years: years,
        type: _mortgageType,
      );
      setState(() => _result = result);
    } catch (e) {
      setState(() => _result = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('房贷计算'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '贷款金额（元）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _principalController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '请输入贷款金额',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => _calculate(),
            ),
            const SizedBox(height: 16),
            const Text(
              '年利率（%）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _rateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '请输入年利率',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => _calculate(),
            ),
            const SizedBox(height: 16),
            const Text(
              '贷款年限',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _yearsController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '请输入贷款年限',
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => _calculate(),
            ),
            const SizedBox(height: 16),
            const Text(
              '还款方式',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SegmentedButton<MortgageType>(
              segments: const [
                ButtonSegment(
                  value: MortgageType.equalPayment,
                  label: Text('等额本息'),
                ),
                ButtonSegment(
                  value: MortgageType.equalPrincipal,
                  label: Text('等额本金'),
                ),
              ],
              selected: {_mortgageType},
              onSelectionChanged: (Set<MortgageType> newSelection) {
                setState(() {
                  _mortgageType = newSelection.first;
                  _calculate();
                });
              },
            ),
            const SizedBox(height: 24),
            if (_result != null) ...[
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '计算结果',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(height: 24),
                      _buildResultRow(
                        '月供金额',
                        '¥${_calculator.formatAmount(_result!.monthlyPayment)} 元',
                      ),
                      const SizedBox(height: 12),
                      _buildResultRow(
                        '还款总额',
                        '¥${_calculator.formatAmount(_result!.totalPayment)} 元',
                      ),
                      const SizedBox(height: 12),
                      _buildResultRow(
                        '利息总额',
                        '¥${_calculator.formatAmount(_result!.totalInterest)} 元',
                      ),
                      if (_mortgageType == MortgageType.equalPrincipal) ...[
                        const SizedBox(height: 12),
                        _buildResultRow(
                          '首月月供',
                          '¥${_calculator.formatAmount(_result!.monthlyPayment)} 元',
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _showScheduleDialog(context),
                icon: const Icon(Icons.list),
                label: const Text('查看还款计划表'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ] else
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    '请输入有效的贷款信息',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _showScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('还款计划表（前 12 期）'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 12,
            itemBuilder: (context, index) {
              final payment = _result!.schedule[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '第 ${payment.month} 期',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '月供: ¥${_calculator.formatAmount(payment.payment, decimals: 0)}',
                      ),
                      Text(
                        '本金: ¥${_calculator.formatAmount(payment.principal, decimals: 0)}',
                      ),
                      Text(
                        '利息: ¥${_calculator.formatAmount(payment.interest, decimals: 0)}',
                      ),
                      Text(
                        '剩余: ¥${_calculator.formatAmount(payment.remainingPrincipal, decimals: 0)}',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _principalController.dispose();
    _rateController.dispose();
    _yearsController.dispose();
    super.dispose();
  }
}
