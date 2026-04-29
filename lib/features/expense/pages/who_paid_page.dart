import 'package:flutter/material.dart';
import 'package:splix_mobile/core/widgets/amount_input_field.dart';

class WhoPaidPage extends StatefulWidget {
  final String currencyCode;
  const WhoPaidPage({super.key, this.currencyCode = 'USD'});

  @override
  State<WhoPaidPage> createState() => _WhoPaidPageState();
}

class _WhoPaidPageState extends State<WhoPaidPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPerson = 'Myself';
  final List<String> _connections = ['John Doe', 'Alice Smith', 'Bob Johnson'];
  final Map<String, TextEditingController> _amountControllers = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _amountControllers['Myself'] = TextEditingController();
    for (var connection in _connections) {
      _amountControllers[connection] = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Who paid?'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Single person'),
            Tab(text: 'Multiple people'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildSinglePersonList(), _buildMultiplePeopleList()],
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
            child: const Text('Done'),
          ),
        ),
      ),
    );
  }

  Widget _buildSinglePersonList() {
    final all = ['Myself', ..._connections];
    return RadioGroup<String>(
      groupValue: _selectedPerson,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedPerson = value;
          });
        }
      },
      child: ListView.builder(
        itemCount: all.length,
        itemBuilder: (context, index) {
          final person = all[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.withValues(alpha: 0.1),
              child: Text(
                person == 'Myself' ? 'Y' : person[0],
                style: const TextStyle(color: Colors.green),
              ),
            ),
            title: Text(person),
            trailing: Radio<String>(value: person, activeColor: Colors.green),
            onTap: () {
              setState(() {
                _selectedPerson = person;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildMultiplePeopleList() {
    final all = ['Myself', ..._connections];
    return ListView.builder(
      itemCount: all.length,
      itemBuilder: (context, index) {
        final person = all[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green.withValues(alpha: 0.1),
            child: Text(
              person == 'Myself' ? 'Y' : person[0],
              style: const TextStyle(color: Colors.green),
            ),
          ),
          title: Text(person),
          trailing: AmountInputField(
            controller: _amountControllers[person]!,
            prefix: '${widget.currencyCode} ',
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var controller in _amountControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
