import '../models/problem.dart';

class Task {
  final int id;
  final String title;
  final int credits;
  final String emoji;
  final List<Problem> type;

  Task({
    required this.id,
    required this.title,
    required this.credits,
    required this.emoji,
    required this.type,
  });
}
