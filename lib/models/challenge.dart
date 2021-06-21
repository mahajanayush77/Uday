import '../models/problem.dart';
import '../models/reward.dart';
import '../models/task.dart';

class Challenge {
  final int? id;
  final int idealLevel;
  final int? actualLevel; // after completing tasks
  final int initialLevel;
  final Set<Task> tasks;
  final Reward reward;
  final DateTime remindAt;
  final ProblemDetails problem;

  Challenge({
    this.actualLevel,
    this.id,
    required this.idealLevel,
    required this.initialLevel,
    required this.tasks,
    required this.reward,
    required this.remindAt,
    required this.problem,
  });

  Map<String, dynamic> toMap() => {
        'actual_level': actualLevel,
        'ideal_level': idealLevel,
        'initial_level': initialLevel,
        'reward_id': reward.id,
        'remind_at': remindAt.millisecondsSinceEpoch,
        'condition': problem.noun,
      };
  factory Challenge.fromMap(Map<String, dynamic> m) => Challenge(
        actualLevel: m['actual_level'],
        id: m['id'],
        idealLevel: m['ideal_level'],
        initialLevel: m['initial_level'],
        tasks: (m['tasks'] as List).map((t) => Task.fromMap(t)).toSet(),
        reward: Reward.fromMap(m['reward']),
        remindAt: DateTime.fromMillisecondsSinceEpoch(m['remind_at']),
        problem: getProblemDetailsByNoun(m['condition']),
      );
}
