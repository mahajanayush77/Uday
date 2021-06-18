import '../models/reward.dart';
import '../models/task.dart';

class Challenge {
  final int id;
  final int idealLevel;
  final int actualLevel; // after completing tasks
  final int initialLevel;
  final Set<Task> tasks;
  final Reward reward;
  final DateTime created;

  Challenge(
    this.actualLevel, {
    required this.id,
    required this.idealLevel,
    required this.initialLevel,
    required this.tasks,
    required this.reward,
    required this.created,
  });
}
