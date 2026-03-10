import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../services/dio_service.dart';
import '../model/task_model.dart';


class TaskService {
  final Dio _dio = DioService().dio;

  String get _userId {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    return user.uid;
  }

  String get _taskPath => '/${ApiConstants.tasks}/$_userId';

  Future<List<TaskModel>> fetchTasks() async {
    try {
      final response = await _dio.get('$_taskPath.json');

      if (response.data == null) {
        return [];
      }

      final Map<String, dynamic> data =
          Map<String, dynamic>.from(response.data as Map);

      final tasks = data.entries.map((entry) {
        return TaskModel.fromJson(
          entry.key,
          Map<String, dynamic>.from(entry.value),
        );
      }).toList();

      tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return tasks;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  Future<String> createTask(TaskModel task) async {
    try {
      final response = await _dio.post(
        '$_taskPath.json',
        data: task.toJson(),
      );

      final responseData = Map<String, dynamic>.from(response.data as Map);
      return responseData['name'] as String;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Failed to create task: $e');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _dio.patch(
        '$_taskPath/${task.id}.json',
        data: task.toJson(),
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _dio.delete(
        '$_taskPath/$taskId.json',
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  String _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout. Please try again.';
    }

    if (e.type == DioExceptionType.receiveTimeout) {
      return 'Server is taking too long to respond.';
    }

    if (e.type == DioExceptionType.badResponse) {
      return 'Server error: ${e.response?.statusCode}';
    }

    if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection.';
    }

    return e.message ?? 'Something went wrong.';
    }
}