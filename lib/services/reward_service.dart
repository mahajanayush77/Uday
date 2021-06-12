import '../models/reward.dart';

class RewardService {
  final rewards = [
    Reward(
      id: 1,
      title: 'Ice Cream',
      emoji: '🍦',
    ),
    Reward(
      id: 2,
      title: 'Nap',
      emoji: '😴',
    ),
    Reward(
      id: 3,
      title: 'Personal Praise',
      emoji: '🙌',
    ),
  ];

  Future<List<Reward>> getAllRewards() async {
    return rewards.map((t) => t).toList();
  }
}
