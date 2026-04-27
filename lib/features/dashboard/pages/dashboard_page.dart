import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expenses Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              child: ListTile(
                title: Text('You are owed'),
                trailing: Text('\$0.00', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('You owe'),
                trailing: Text('\$0.00', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => context.push('/friends'),
                    icon: const Icon(Icons.person),
                    label: const Text('Friends'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => context.push('/groups'),
                    icon: const Icon(Icons.group),
                    label: const Text('Groups'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-expense'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
