import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controller/task_controller.dart';

class EmptyTaskView extends StatelessWidget {
  const EmptyTaskView({
    super.key,
    required this.onAddTask,
  });

  final VoidCallback onAddTask;

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>();
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 96,
              width: 96,
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(AppRadius.xxl),
              ),
              child: const Icon(
                Icons.playlist_add_check_circle_rounded,
                size: 46,
                color: AppColors.primary,
              ),
            ),
            AppSpacing.gapXl,
            Text(
              'No tasks yet',
              style: textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            AppSpacing.gapSm,
            Text(
              'Start by creating your first task and keep your day organized.',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.gapXxl,
        // taskController.filteredTasks.isEmpty?    PrimaryButton(
        //       text: 'Add New Task',
        //       onPressed: onAddTask,
        //     ):const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}