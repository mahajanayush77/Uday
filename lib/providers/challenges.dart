import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/challenge.dart';

class Challenges with ChangeNotifier {
  final Database _database;
  Challenge? _latestChallengeToday;

  Challenges(this._database) {
    fetchAndSetLatestChallenge();
  }

  Challenge? get latestChallenge {
    return _latestChallengeToday;
  }

  Future<void> fetchAndSetLatestChallenge() async {
    try {
      final challengeResponse = await _database.query(
        'challenges',
        where:
            "DATE(created_at/1000, 'unixepoch', 'localtime') = Date('now', 'localtime') AND actual_level IS NULL",
        orderBy: 'created_at DESC',
        limit: 1,
      );

      if (challengeResponse.length < 1) return;

      final challengeId = challengeResponse[0]['id'] as int;
      final tasksResponse = await _database.query(
        'tasks',
        where:
            'id IN (SELECT task_id FROM challenges_tasks WHERE challenge_id=?)',
        whereArgs: [challengeId],
      );

      final rewardResponse = await _database.query(
        'rewards',
        where: 'id=?',
        whereArgs: [challengeResponse[0]['reward_id'] as int],
      );

      _latestChallengeToday = Challenge.fromMap(
        {
          ...challengeResponse[0],
          'tasks': tasksResponse,
          'reward': rewardResponse[0],
        },
      );

      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> create(Challenge challenge) async {
    try {
      await _database.transaction((tx) async {
        var newChallengeId = 1;
        final mostRecentChallengeList = await tx.query(
          'challenges',
          orderBy: 'id DESC',
          limit: 1,
        );

        if (mostRecentChallengeList.length > 0) {
          newChallengeId = (mostRecentChallengeList[0]['id'] as int) + 1;
        }

        final batch = tx.batch();

        final challengeToInsert = challenge.toMap();
        challengeToInsert['id'] = newChallengeId;
        challengeToInsert['created_at'] = DateTime.now().millisecondsSinceEpoch;
        batch.insert(
          'challenges',
          challengeToInsert,
        );

        challenge.tasks.forEach((t) {
          batch.insert('challenges_tasks', {
            'challenge_id': newChallengeId,
            'task_id': t.id,
          });
        });

        await batch.commit();
      });
      await fetchAndSetLatestChallenge();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> endChallenge(int? challengeId, int updatedLevel) async {
    try {
      await _database.update(
        'challenges',
        {'actual_level': updatedLevel},
        where: 'id=?',
        whereArgs: [challengeId],
      );
      await fetchAndSetLatestChallenge();
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }
}
