import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_spacing.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showIcon = true,
  });

  final String title;
  final String subtitle;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showIcon) ...[
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.primary,
              size: 34,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
        Text(
          title,
          style: textTheme.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          subtitle,
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}