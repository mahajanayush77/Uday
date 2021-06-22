import '../models/problem.dart';

ProblemDetails getProblemDetailsByNoun(String noun) {
  switch (noun.toLowerCase()) {
    case 'anxiety':
      return getProblemDetails(Problem.Anxiety);
    case 'stress':
      return getProblemDetails(Problem.Stress);
    case 'depression':
      return getProblemDetails(Problem.Depression);
    default:
      throw Exception('Problem noun is not recognised.');
  }
}

class Task {
  final int id;
  final String title;
  final int credits;
  final String emoji;

  Task({
    required this.id,
    required this.title,
    required this.credits,
    required this.emoji,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'credits': credits,
        'emoji': emoji,
      };
  factory Task.fromMap(Map<String, dynamic> m) => Task(
        id: m['id'],
        title: m['title'],
        credits: m['credits'],
        emoji: m['emoji'],
      );
}
