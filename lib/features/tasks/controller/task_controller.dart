import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/model/task_model.dart';
import '../data/services/task_service.dart';



class TaskController extends GetxController {
  final TaskService _taskService = TaskService();

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final tasks = <TaskModel>[].obs;
  final selectedFilter = TaskFilter.all.obs;

  final isLoading = false.obs;
  final isSaving = false.obs;
  final isDeleting = false.obs;

  final editingTask = Rxn<TaskModel>();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  List<TaskModel> get filteredTasks {
    switch (selectedFilter.value) {
      case TaskFilter.pending:
        return tasks.where((task) => !task.isCompleted).toList();
      case TaskFilter.completed:
        return tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.all:
        return tasks;
    }
  }

  int get totalTasks => tasks.length;

  int get completedTasks => tasks.where((task) => task.isCompleted).length;

  int get pendingTasks => tasks.where((task) => !task.isCompleted).length;

  void changeFilter(TaskFilter filter) {
    selectedFilter.value = filter;
  }

  void setEditingTask(TaskModel? task) {
    editingTask.value = task;

    if (task != null) {
      titleController.text = task.title;
      descriptionController.text = task.description ?? '';
    } else {
      clearForm();
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    editingTask.value = null;
  }

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter task title';
    }
    if (value.trim().length < 3) {
      return 'Title must be at least 3 characters';
    }
    return null;
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      final fetchedTasks = await _taskService.fetchTasks();
      tasks.assignAll(fetchedTasks);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitTask() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    try {
      isSaving.value = true;

      if (editingTask.value == null) {
        final newTask = TaskModel(
          id: '',
          title: titleController.text.trim(),
          description: descriptionController.text.trim().isEmpty
              ? null
              : descriptionController.text.trim(),
          isCompleted: false,
          createdAt: DateTime.now(),
        );

        await _taskService.createTask(newTask);

        Get.back();

        Get.snackbar(
          'Success',
          'Task created successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        final updatedTask = editingTask.value!.copyWith(
          title: titleController.text.trim(),
          description: descriptionController.text.trim().isEmpty
              ? null
              : descriptionController.text.trim(),
        );

        await _taskService.updateTask(updatedTask);

        Get.back();

        Get.snackbar(
          'Success',
          'Task updated successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      clearForm();
      await fetchTasks();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> toggleTaskStatus(TaskModel task) async {
    try {
      final updatedTask = task.copyWith(
        isCompleted: !task.isCompleted,
      );

      await _taskService.updateTask(updatedTask);
      await fetchTasks();

      Get.snackbar(
        'Success',
        task.isCompleted
            ? 'Task marked as pending'
            : 'Task marked as completed',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      isDeleting.value = true;

      await _taskService.deleteTask(taskId);
      await fetchTasks();

      Get.back();

      Get.snackbar(
        'Deleted',
        'Task deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isDeleting.value = false;
    }
  }
}

enum TaskFilter {
  all,
  pending,
  completed,
}