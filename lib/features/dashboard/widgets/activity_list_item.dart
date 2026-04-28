import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ActivityListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final bool isOwed;
  final IconData icon;

  const ActivityListItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isOwed,
    this.icon = Icons.receipt_long_outlined,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withAlpha(40),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isOwed ? AppTheme.secondaryColor : Colors.redAccent,
                    ),
              ),
              Text(
                isOwed ? 'you are owed' : 'you owe',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
