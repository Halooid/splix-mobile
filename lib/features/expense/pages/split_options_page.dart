import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplitOptionsPage extends StatelessWidget {
  final String personName;
  final List<String> participants;
  final String currencyCode;
  final double totalAmount;

  const SplitOptionsPage({
    super.key,
    required this.personName,
    required this.participants,
    required this.currencyCode,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Split options'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildOption(
                  context,
                  icon: Icons.person_outline,
                  title: 'You paid, split equally',
                  onTap: () => Navigator.pop(context, 'You paid, split equally'),
                ),
                _buildOption(
                  context,
                  icon: Icons.receipt_long_outlined,
                  title: 'You are owed the full amount',
                  onTap: () => Navigator.pop(context, 'You are owed the full amount'),
                ),
                _buildOption(
                  context,
                  icon: Icons.people_outline,
                  title: '$personName paid, split equally',
                  onTap: () => Navigator.pop(context, '$personName paid, split equally'),
                ),
                _buildOption(
                  context,
                  icon: Icons.request_quote_outlined,
                  title: '$personName is owed the full amount',
                  onTap: () => Navigator.pop(context, '$personName is owed the full amount'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton.icon(
              onPressed: () {
                context.push(
                  '/adjust-split',
                  extra: {
                    'participants': participants,
                    'currencyCode': currencyCode,
                    'totalAmount': totalAmount,
                  },
                );
              },
              icon: const Icon(Icons.tune),
              label: const Text('More options'),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.green.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.green, size: 20),
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }
}
