enum Problem {
  Depression,
  Anxiety,
  Stress,
}

class ProblemDetails {
  final Problem type;
  final String noun;
  final String adjective;

  ProblemDetails({
    required this.type,
    required this.noun,
    required this.adjective,
  });
}

ProblemDetails getProblemDetails(Problem type) {
  switch (type) {
    case Problem.Depression:
      return ProblemDetails(
          type: Problem.Depression, noun: 'Depression', adjective: 'Depressed');
    case Problem.Anxiety:
      return ProblemDetails(
          type: Problem.Anxiety, noun: 'Anxiety', adjective: 'Anxious');
    case Problem.Stress:
      return ProblemDetails(
          type: Problem.Stress, noun: 'Stress', adjective: 'Stressed');
    default:
      throw Exception('Problem type is not recognised');
  }
}
