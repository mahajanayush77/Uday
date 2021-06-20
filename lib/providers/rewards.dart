import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/reward.dart';

class Rewards with ChangeNotifier {
  final Database _database;

  Rewards(this._database);

  List<Reward> _rewards = [];

  List<Reward> get rewards {
    return _rewards.map((t) => t).toList();
  }

  Future<void> fetchAndSetRewards() async {
    try {
      final response = await _database.query('rewards');
      _rewards = response.map((r) => Reward.fromMap(r)).toList();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
