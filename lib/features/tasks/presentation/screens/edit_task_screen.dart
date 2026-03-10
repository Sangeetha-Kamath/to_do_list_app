import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../controller/task_controller.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    final isEditing = controller.editingTask.value != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'Add Task'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  controller: controller.titleController,
                  labelText: 'Task Title',
                  hintText: 'Enter task title',
                  textInputAction: TextInputAction.next,
                  validator: controller.validateTitle,
                ),
                AppSpacing.gapLg,
                AppTextField(
                  controller: controller.descriptionController,
                  labelText: 'Description',
                  hintText: 'Enter task description',
                  maxLines: 5,
                  minLines: 4,
                ),
                AppSpacing.gapXxl,
                Obx(
                  () => PrimaryButton(
                    text: isEditing ? 'Save Changes' : 'Create Task',
                    isLoading: controller.isSaving.value,
                    onPressed: controller.submitTask,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}