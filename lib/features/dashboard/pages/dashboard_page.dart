import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/donut_chart_section.dart';
import '../widgets/activity_list_item.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const DonutChartSection(
              youOwe: 450.00,
              youAreOwed: 1250.00,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const ActivityListItem(
              title: 'Dinner at Nobu',
              subtitle: 'Split with Alex, Sarah',
              amount: '\$120.00',
              isOwed: true,
              icon: Icons.restaurant,
            ),
            const ActivityListItem(
              title: 'Weekly Groceries',
              subtitle: 'Shared with Roommate',
              amount: '\$45.50',
              isOwed: false,
              icon: Icons.shopping_cart_outlined,
            ),
            const ActivityListItem(
              title: 'Gas Refill',
              subtitle: 'Trip to Tahoe',
              amount: '\$32.00',
              isOwed: true,
              icon: Icons.local_gas_station_outlined,
            ),
            const ActivityListItem(
              title: 'Netflix Subscription',
              subtitle: 'Family Plan',
              amount: '\$15.99',
              isOwed: false,
              icon: Icons.tv,
            ),
            const SizedBox(height: 100), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-expense'),
        icon: const Icon(Icons.add),
        label: const Text('Add Expense'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
