import 'package:flutter/material.dart';
import 'package:conversion_kit/conversion_kit.dart';
import 'screens/unit_converter_screen.dart';
import 'screens/currency_converter_screen.dart';
import 'screens/mortgage_calculator_screen.dart';

void main() {
  runApp(const ConversionKitDemoApp());
}

class ConversionKitDemoApp extends StatelessWidget {
  const ConversionKitDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConversionKit 演示',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConversionKit 演示'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '选择功能',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildFeatureCard(
              context,
              icon: Icons.straighten,
              title: '单位换算',
              description: '长度、重量、温度等 9 大类别 60+ 单位',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UnitConverterScreen(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              context,
              icon: Icons.currency_exchange,
              title: '汇率换算',
              description: '支持 12 种主流货币实时汇率转换',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CurrencyConverterScreen(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              context,
              icon: Icons.home,
              title: '房贷计算',
              description: '等额本息、等额本金、提前还款计算',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MortgageCalculatorScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
