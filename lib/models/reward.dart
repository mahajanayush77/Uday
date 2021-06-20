class Reward {
  final int id;
  final String title;
  final String emoji;

  Reward({
    required this.id,
    required this.title,
    required this.emoji,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'emoji': emoji,
      };

  factory Reward.fromMap(Map<String, dynamic> m) => Reward(
        id: m['id'],
        title: m['title'],
        emoji: m['emoji'],
      );
}
