import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splix_mobile/core/widgets/glass_bottom_sheet.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  // Connection field state
  final List<String> _selectedConnections = [];
  int _backspaceCount = 0;
  TextEditingController? _autocompleteController;
  final List<String> _dummyConnections = [
    'John Doe',
    'Alice Smith',
    'Bob Johnson',
    'Charlie Brown',
  ];

  // Currency field state
  String _selectedCurrency = 'USD';
  final List<String> _currencies = [
    'USD',
    'EUR',
    'GBP',
    'INR',
    'JPY',
    'AUD',
    'CAD',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement save
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Connection Name Text Area
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _dummyConnections.where((String option) {
                    return option.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        ) &&
                        !_selectedConnections.contains(option);
                  });
                },
                onSelected: (String selection) {
                  setState(() {
                    _selectedConnections.add(selection);
                    _backspaceCount = 0;
                  });
                  _autocompleteController?.clear();
                },
                fieldViewBuilder: (
                  context,
                  controller,
                  focusNode,
                  onEditingComplete,
                ) {
                  _autocompleteController = controller;
                  focusNode.onKeyEvent ??= (node, event) {
                    if (event is KeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.backspace) {
                      if (controller.text.isEmpty &&
                          _selectedConnections.isNotEmpty) {
                        setState(() {
                          _backspaceCount++;
                          if (_backspaceCount >= 2) {
                            _selectedConnections.removeLast();
                            _backspaceCount = 0;
                          }
                        });
                        return KeyEventResult.handled;
                      }
                    }
                    if (event is KeyDownEvent &&
                        event.logicalKey != LogicalKeyboardKey.backspace) {
                      _backspaceCount = 0;
                    }
                    return KeyEventResult.ignored;
                  };

                  return InputDecorator(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 4),
                      isDense: true,
                    ),
                    isFocused: focusNode.hasFocus,
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text(
                            'With you and ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ..._selectedConnections.map((c) {
                            final isLast = c == _selectedConnections.last;
                            return Chip(
                              label: Text(
                                c,
                                style: const TextStyle(fontSize: 12),
                              ),
                              padding: EdgeInsets.zero,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              backgroundColor:
                                  isLast && _backspaceCount == 1
                                      ? Colors.red.shade100
                                      : null,
                              onDeleted: () {
                                setState(() {
                                  _selectedConnections.remove(c);
                                  _backspaceCount = 0;
                                });
                              },
                            );
                          }),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              controller: controller,
                              focusNode: focusNode,
                              onEditingComplete: onEditingComplete,
                              decoration: const InputDecoration(
                                hintText: 'type name',
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // 2. Description text box
              TextField(
                controller: _descriptionController,
                maxLength: 50,
                buildCounter:
                    (
                      context, {
                      required currentLength,
                      required isFocused,
                      required maxLength,
                    }) => null,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'What was it for?',
                  prefixIcon: Icon(Icons.description_outlined, size: 20),
                  border: UnderlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // 3. Currency and Amount
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: _showCurrencyPicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            _selectedCurrency,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.arrow_drop_down, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        hintText: '0.00',
                        border: UnderlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 4. Paid by and Split
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Paid by '),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green.withValues(alpha: 0.1),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      minimumSize: const Size(0, 32),
                    ),
                    child: const Text(
                      'you',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  const Text(' and split '),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green.withValues(alpha: 0.1),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      minimumSize: const Size(0, 32),
                    ),
                    child: const Text(
                      'equally',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // 5. Bottom Row
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.group_add_outlined),
                    label: const Text('Add Group'),
                  ),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.notes), onPressed: () {}),
                  IconButton(
                    icon: const Icon(Icons.image_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCurrencyPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (context) {
        return GlassBottomSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return CurrencyPickerContent(
              scrollController: scrollController,
              currencies: _currencies,
              onSelected: (currency) {
                setState(() {
                  _selectedCurrency = currency;
                });
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}

class CurrencyPickerContent extends StatefulWidget {
  final List<String> currencies;
  final ValueChanged<String> onSelected;
  final ScrollController scrollController;

  const CurrencyPickerContent({
    super.key,
    required this.currencies,
    required this.onSelected,
    required this.scrollController,
  });

  @override
  State<CurrencyPickerContent> createState() => _CurrencyPickerContentState();
}

class _CurrencyPickerContentState extends State<CurrencyPickerContent> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredCurrencies =
        widget.currencies
            .where((c) => c.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search currency',
              prefixIcon: const Icon(Icons.search),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              isDense: true,
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: widget.scrollController,
            itemCount: filteredCurrencies.length,
            itemBuilder: (context, index) {
              final currency = filteredCurrencies[index];
              return ListTile(
                title: Text(currency),
                onTap: () {
                  widget.onSelected(currency);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
