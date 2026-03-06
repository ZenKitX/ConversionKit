import 'package:flutter/material.dart';
import 'package:conversion_kit/conversion_kit.dart';

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final _converter = UnitConverter();
  final _inputController = TextEditingController(text: '1');
  
  String? _selectedCategoryId;
  String? _fromUnitId;
  String? _toUnitId;
  String _result = '';

  List<ConversionCategory> _categories = [];
  List<ConversionUnit> _units = [];

  @override
  void initState() {
    super.initState();
    _categories = _converter.getAllCategories();
    if (_categories.isNotEmpty) {
      _selectedCategoryId = _categories[0].id;
      _loadUnits();
    }
  }

  void _loadUnits() {
    if (_selectedCategoryId != null) {
      _units = _converter.getUnits(_selectedCategoryId!) ?? [];
      if (_units.length >= 2) {
        _fromUnitId = _units[0].id;
        _toUnitId = _units[1].id;
      }
      _convert();
    }
  }

  void _convert() {
    if (_selectedCategoryId == null || _fromUnitId == null || _toUnitId == null) {
      return;
    }

    final input = _inputController.text;
    if (input.isEmpty) {
      setState(() => _result = '');
      return;
    }

    try {
      if (_selectedCategoryId == 'number_system') {
        final result = _converter.convertNumberSystem(
          value: input,
          fromUnitId: _fromUnitId!,
          toUnitId: _toUnitId!,
        );
        setState(() => _result = result);
      } else {
        final value = double.tryParse(input);
        if (value == null) {
          setState(() => _result = '请输入有效数字');
          return;
        }
        final result = _converter.convert(
          value: value,
          categoryId: _selectedCategoryId!,
          fromUnitId: _fromUnitId!,
          toUnitId: _toUnitId!,
        );
        setState(() => _result = _converter.formatResult(result));
      }
    } catch (e) {
      setState(() => _result = '转换错误: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('单位换算'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('选择类别', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedCategoryId,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category.id,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategoryId = value;
                  _loadUnits();
                });
              },
            ),
            const SizedBox(height: 24),
            const Text('输入数值', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '请输入数值',
              ),
              keyboardType: _selectedCategoryId == 'number_system' 
                  ? TextInputType.text 
                  : const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => _convert(),
            ),
            const SizedBox(height: 24),
            const Text('从', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _fromUnitId,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _units.map((unit) {
                return DropdownMenuItem(
                  value: unit.id,
                  child: Text('${unit.name} (${unit.symbol})'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _fromUnitId = value;
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
                    final temp = _fromUnitId;
                    _fromUnitId = _toUnitId;
                    _toUnitId = temp;
                    _convert();
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text('到', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _toUnitId,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _units.map((unit) {
                return DropdownMenuItem(
                  value: unit.id,
                  child: Text('${unit.name} (${unit.symbol})'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _toUnitId = value;
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
                    Text(
                      _result.isEmpty ? '等待输入...' : _result,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
