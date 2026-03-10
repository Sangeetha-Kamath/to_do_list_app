import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/dialog_helper.dart';
import '../../../login/controller/auth_controller.dart';
import '../../controller/task_controller.dart';
import '../../widgets/empty_task_view.dart';
import '../../widgets/task_card.dart';
import '../../widgets/task_filter_chips.dart';
import '../../widgets/task_summary_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  String _formatDate() {
    final now = DateTime.now();
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>();
    final authController = Get.find<AuthController>();
    final textTheme = Theme.of(context).textTheme;

    final userName =
        authController.currentUser?.displayName?.trim().isNotEmpty == true
        ? authController.currentUser!.displayName!
        : 'User';

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          taskController.clearForm();
          Get.toNamed(AppRoutes.editTask);
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Task'),
      ),

      body: SafeArea(
  child: Obx(
    () => Column(
      children: [
        /// HEADER (FIXED)
        Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_getGreeting()},',
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        AppSpacing.gapXs,
                        Text(
                          userName,
                          style: textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        AppSpacing.gapSm,
                        Text(
                          _formatDate(),
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      DialogHelper.showConfirmation(
                        title: "Logout",
                        message: "Are you sure you want to logout?",
                        confirmText: "Logout",
                        isDanger: true,
                        onConfirm: authController.logout,
                      );
                    },
                    icon: const Icon(Icons.logout_rounded),
                  ),
                ],
              ),

              AppSpacing.gapXxl,

              TaskSummaryCard(
                totalTasks: taskController.totalTasks,
                completedTasks: taskController.completedTasks,
                pendingTasks: taskController.pendingTasks,
              ),

              AppSpacing.gapXxl,

              Text(
                'My Tasks',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              AppSpacing.gapMd,

              const TaskFilterChips(),

              AppSpacing.gapMd,
            ],
          ),
        ),

        /// TASK LIST (SCROLLABLE)
        Expanded(
          child: RefreshIndicator(
            onRefresh: taskController.fetchTasks,
            child: taskController.isLoading.value &&
                    taskController.tasks.isEmpty
                ? const Center(child: CircularProgressIndicator())

                : taskController.filteredTasks.isEmpty
                    ? EmptyTaskView(
                        onAddTask: () {
                          taskController.clearForm();
                          Get.toNamed(AppRoutes.editTask);
                        },
                      )

                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                        itemCount: taskController.filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task =
                              taskController.filteredTasks[index];

                          return TaskCard(
                            task: task,
                            onToggle: () =>
                                taskController.toggleTaskStatus(task),
                            onEdit: () {
                              taskController.setEditingTask(task);
                              Get.toNamed(AppRoutes.editTask);
                            },
                            onDelete: () {
                              DialogHelper.showConfirmation(
                                title: "Delete Task",
                                message:
                                    "This task will be permanently deleted.",
                                confirmText: "Delete",
                                isDanger: true,
                                onConfirm: () =>
                                    taskController.deleteTask(task.id),
                              );
                            },
                          );
                        },
                        separatorBuilder: (_, __) => AppSpacing.gapLg,
                      ),
          ),
        ),
      ],
    ),
  ),
     ), );
  }
}
