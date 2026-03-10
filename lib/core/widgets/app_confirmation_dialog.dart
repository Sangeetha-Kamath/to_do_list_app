import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmText = "Confirm",
    this.cancelText = "Cancel",
    this.isDanger = false,
  });

  final String title;
  final String message;
  final VoidCallback onConfirm;
  final String confirmText;
  final String cancelText;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            AppSpacing.gapMd,

            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),

            AppSpacing.gapXl,

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    child: Text(cancelText),
                  ),
                ),

                AppSpacing.gapWmd,

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDanger ? AppColors.error : AppColors.primary,
                    ),
                    onPressed: () {
                      Get.back();
                      onConfirm();
                    },
                    child: Text(confirmText),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}