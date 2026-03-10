import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
  });

  final int totalTasks;
  final int completedTasks;
  final int pendingTasks;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task Overview',
            style: textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          AppSpacing.gapSm,
          Text(
            'Stay on top of your daily progress',
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.85),
            ),
          ),
          AppSpacing.gapXl,
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  label: 'Total',
                  value: totalTasks.toString(),
                ),
              ),
              Expanded(
                child: _SummaryItem(
                  label: 'Completed',
                  value: completedTasks.toString(),
                ),
              ),
              Expanded(
                child: _SummaryItem(
                  label: 'Pending',
                  value: pendingTasks.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        AppSpacing.gapXs,
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.white.withOpacity(0.85),
          ),
        ),
      ],
    );
  }
}