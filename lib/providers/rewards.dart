import 'package:flutter/material.dart';
import '../models/reward.dart';
import '../services/reward_service.dart';

class Rewards with ChangeNotifier {
  final _rewardService = RewardService();

  List<Reward> _rewards = [];

  List<Reward> get rewards {
    return _rewards.map((t) => t).toList();
  }

  Future<void> fetchAndSetRewards() async {
    try {
      _rewards = await _rewardService.getAllRewards();
    } catch (e) {
      throw e;
    }
  }
}
