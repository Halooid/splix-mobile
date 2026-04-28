import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_container.dart';

class DonutChartSection extends StatelessWidget {
  final double youOwe;
  final double youAreOwed;

  const DonutChartSection({
    required this.youOwe,
    required this.youAreOwed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final total = youOwe + youAreOwed;
    final owePercent = total == 0 ? 0.0 : (youOwe / total) * 100;
    final owedPercent = total == 0 ? 0.0 : (youAreOwed / total) * 100;

    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expense Overview',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                height: 140,
                width: 140,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 40,
                    sections: [
                      PieChartSectionData(
                        value: youAreOwed == 0 && youOwe == 0 ? 1 : youAreOwed,
                        color: youAreOwed == 0 && youOwe == 0 ? Colors.grey[300] : AppTheme.secondaryColor,
                        title: youAreOwed == 0 ? '' : '${owedPercent.toStringAsFixed(0)}%',
                        radius: 50,
                        titleStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: youOwe,
                        color: Colors.redAccent,
                        title: youOwe == 0 ? '' : '${owePercent.toStringAsFixed(0)}%',
                        radius: 50,
                        titleStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(
                      context,
                      'You are owed',
                      '\$${youAreOwed.toStringAsFixed(2)}',
                      AppTheme.secondaryColor,
                    ),
                    const SizedBox(height: 16),
                    _buildLegendItem(
                      context,
                      'You owe',
                      '\$${youOwe.toStringAsFixed(2)}',
                      Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    String label,
    String amount,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                amount,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
