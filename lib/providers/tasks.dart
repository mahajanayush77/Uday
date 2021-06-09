import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class Tasks with ChangeNotifier {
  final _taskService = TaskService();
  List<Task> _tasks = [];

  List<Task> get tasks {
    return _tasks.map((t) => t).toList();
  }

  Future<void> fetchAndSetTasks() async {
    try {
      _tasks = await _taskService.getAllTasks();
    } catch (e) {
      throw e;
    }
  }
}
