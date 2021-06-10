import '../models/problem.dart';
import '../models/task.dart';

class TaskService {
  final tasks = [
    Task(
      id: 1,
      title: 'Jog',
      credits: 2,
      emoji: '🏃',
      type: [Problem.Stress, Problem.Anxiety],
    ),
    Task(
      id: 2,
      title: 'Meditate',
      credits: 2,
      emoji: '🧘',
      type: [Problem.Stress, Problem.Anxiety, Problem.Depression],
    ),
    Task(
      id: 3,
      title: 'Talk to a friend',
      credits: 3,
      emoji: '🗣️',
      type: [Problem.Stress, Problem.Anxiety, Problem.Depression],
    ),
  ];

  Future<List<Task>> getAllTasks() async {
    return tasks.map((t) => t).toList();
  }
}
