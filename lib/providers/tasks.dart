import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class Tasks with ChangeNotifier {
  final Database _database;
  Tasks(this._database);
  List<Task> _tasks = [];

  List<Task> get tasks {
    return _tasks.map((t) => t).toList();
  }

  Future<void> fetchAndSetTasks() async {
    try {
      final response = await _database.query('tasks');
      _tasks = response.map((t) => Task.fromMap(t)).toList();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
