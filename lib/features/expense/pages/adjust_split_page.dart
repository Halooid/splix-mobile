import 'package:flutter/material.dart';
import 'package:splix_mobile/core/widgets/amount_input_field.dart';

class AdjustSplitPage extends StatefulWidget {
  final List<String> participants;
  final String currencyCode;
  final double totalAmount;

  const AdjustSplitPage({
    super.key,
    required this.participants,
    required this.currencyCode,
    required this.totalAmount,
  });

  @override
  State<AdjustSplitPage> createState() => _AdjustSplitPageState();
}

class _AdjustSplitPageState extends State<AdjustSplitPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, bool> _selectedEqually = {};
  final Map<String, TextEditingController> _unequallyControllers = {};
  final Map<String, TextEditingController> _percentageControllers = {};
  final Map<String, TextEditingController> _sharesControllers = {};
  final Map<String, TextEditingController> _adjustmentControllers = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    for (var p in widget.participants) {
      _selectedEqually[p] = true;
      _unequallyControllers[p] = TextEditingController();
      _percentageControllers[p] = TextEditingController();
      _sharesControllers[p] = TextEditingController();
      _adjustmentControllers[p] = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adjust split'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Equally'),
            Tab(text: 'Unequally'),
            Tab(text: 'By Percentage'),
            Tab(text: 'By Shares'),
            Tab(text: 'By Adjustment'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEquallyPage(),
          _buildUnequallyPage(),
          _buildPercentagePage(),
          _buildSharesPage(),
          _buildAdjustmentPage(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Save'),
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeader(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEquallyPage() {
    return Column(
      children: [
        _buildPageHeader(
          'Split equally',
          'Select which people owe an equal share',
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.participants.length,
            itemBuilder: (context, index) {
              final p = widget.participants[index];
              return CheckboxListTile(
                value: _selectedEqually[p],
                onChanged: (val) => setState(() => _selectedEqually[p] = val!),
                title: Text(p),
                secondary: CircleAvatar(
                  backgroundColor: Colors.green.withValues(alpha: 0.1),
                  child: Text(
                    p == 'You' ? 'Y' : p[0],
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
                controlAffinity: ListTileControlAffinity.trailing,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUnequallyPage() {
    return Column(
      children: [
        _buildPageHeader(
          'Split by exact amount',
          'Split exactly how each person owes',
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.participants.length,
            itemBuilder: (context, index) {
              final p = widget.participants[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.withValues(alpha: 0.1),
                  child: Text(
                    p == 'You' ? 'Y' : p[0],
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
                title: Text(p),
                trailing: AmountInputField(
                  controller: _unequallyControllers[p]!,
                  prefix: '${widget.currencyCode} ',
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPercentagePage() {
    return Column(
      children: [
        _buildPageHeader(
          'Split by percentage',
          'Split by percentages that\'s fair for your situation',
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.participants.length,
            itemBuilder: (context, index) {
              final p = widget.participants[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.withValues(alpha: 0.1),
                  child: Text(
                    p == 'You' ? 'Y' : p[0],
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
                title: Text(p),
                subtitle: Text(
                  '${widget.currencyCode} 0.00',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                trailing: AmountInputField(
                  controller: _percentageControllers[p]!,
                  suffix: ' %',
                  isInteger: false,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSharesPage() {
    return Column(
      children: [
        _buildPageHeader(
          'Split by shares',
          'Assign shares to each person. E.g. If you have 2 shares and someone has 1, you owe 2/3 of the total.',
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.participants.length,
            itemBuilder: (context, index) {
              final p = widget.participants[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.withValues(alpha: 0.1),
                  child: Text(
                    p == 'You' ? 'Y' : p[0],
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
                title: Text(p),
                subtitle: Text(
                  '${widget.currencyCode} 0.00',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                trailing: ValueListenableBuilder(
                  valueListenable: _sharesControllers[p]!,
                  builder: (context, value, _) {
                    final val = int.tryParse(value.text) ?? 0;
                    final suffix = val == 1 ? ' share' : ' shares';
                    return AmountInputField(
                      controller: _sharesControllers[p]!,
                      suffix: suffix,
                      width: 120,
                      isInteger: true,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAdjustmentPage() {
    return Column(
      children: [
        _buildPageHeader(
          'Split by adjustment',
          'Enter adjustment to reflect who owes more. Splix will distribute the remainder equally',
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.participants.length,
            itemBuilder: (context, index) {
              final p = widget.participants[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.withValues(alpha: 0.1),
                  child: Text(
                    p == 'You' ? 'Y' : p[0],
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
                title: Text(p),
                subtitle: Text(
                  '${widget.currencyCode} 0.00',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                trailing: AmountInputField(
                  controller: _adjustmentControllers[p]!,
                  prefix: '+ ',
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var c in _unequallyControllers.values) {
      c.dispose();
    }
    for (var c in _percentageControllers.values) {
      c.dispose();
    }
    for (var c in _sharesControllers.values) {
      c.dispose();
    }
    for (var c in _adjustmentControllers.values) {
      c.dispose();
    }
    super.dispose();
  }
}
