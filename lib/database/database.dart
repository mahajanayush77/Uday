import 'package:sqflite/sqflite.dart';
import '../models/reward.dart';
import '../models/task.dart';
import 'dart:async';
import 'package:path/path.dart';

final _defaultRewards = [
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

final _defaultTasks = [
  Task(
    id: 1,
    title: 'Jog',
    credits: 2,
    emoji: '🏃',
  ),
  Task(
    id: 2,
    title: 'Meditate',
    credits: 2,
    emoji: '🧘',
  ),
  Task(
    id: 3,
    title: 'Talk to a friend',
    credits: 3,
    emoji: '🗣️',
  ),
];

Future<Database> connectToDB(String dbName) async {
  try {
    return await openDatabase(join(await getDatabasesPath(), '$dbName.db'),
        onCreate: (db, version) async {
      try {
        final batch = db.batch();

        // create and insert default rewards into DB
        batch.execute(
            'CREATE TABLE IF NOT EXISTS rewards(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, emoji TEXT NON NULL);');
        _defaultRewards.forEach((reward) {
          batch.insert('rewards', reward.toMap());
        });

        // create and insert default tasks into DB

        batch.execute(
            'CREATE TABLE IF NOT EXISTS tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, credits INTEGER NOT NULL, emoji TEXT NOT NULL);');
        _defaultTasks.forEach((task) {
          batch.insert('tasks', task.toMap());
        });

        await batch.commit();
      } catch (e) {
        throw (e);
      }
    }, version: 2);
  } catch (e) {
    throw (e);
  }
}
