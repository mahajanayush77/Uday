import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import '../models/reward.dart';
import '../models/task.dart';

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
  Reward(
    id: 4,
    title: 'Mobile Game',
    emoji: '🎮',
  ),
  Reward(
    id: 5,
    title: 'Watch your Favorite Show',
    emoji: '📺',
  ),
  Reward(
    id: 6,
    title: 'Volunteer',
    emoji: '🙋',
  ),
];

final _defaultTasks = [
  Task(
    id: 1,
    title: 'Meditate',
    credits: 1,
    emoji: '🧘',
  ),
  Task(
    id: 2,
    title: 'Watch a TED Talk',
    credits: 1,
    emoji: '📺',
  ),
  Task(
    id: 3,
    title: 'Jog',
    credits: 2,
    emoji: '🏃',
  ),
  Task(
    id: 4,
    title: 'Read a book',
    credits: 2,
    emoji: '📚',
  ),
  Task(
    id: 5,
    title: 'Stroll',
    credits: 2,
    emoji: '🚶🏻‍♀️',
  ),
  Task(
    id: 6,
    title: 'Journal your thoughts',
    credits: 3,
    emoji: '📝️',
  ),
  Task(
    id: 7,
    title: 'Bake',
    credits: 3,
    emoji: '🎂',
  ),
  Task(
    id: 8,
    title: 'Talk to a friend',
    credits: 4,
    emoji: '🗣️',
  ),
  Task(
    id: 9,
    title: 'Help someone in need',
    credits: 4,
    emoji: '💪',
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

        // create challenges table
        batch.execute(
            'CREATE TABLE IF NOT EXISTS challenges(id INTEGER PRIMARY KEY AUTOINCREMENT, initial_level INTEGER NOT NULL, ideal_level INTEGER NOT NULL, actual_level INTEGER, reward_id INTEGER NOT NULL, created_at INTEGER NOT NULL, remind_at INTEGER NOT NULL, condition TEXT NOT NULL, FOREIGN KEY(reward_id) REFERENCES rewards(id));');

        // create challenges tasks table
        batch.execute(
            'CREATE TABLE IF NOT EXISTS challenges_tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, challenge_id INTEGER NOT NULL, task_id INTEGER NOT NULL);');
        await batch.commit();
      } catch (e) {
        throw (e);
      }
    }, version: 2);
  } catch (e) {
    throw (e);
  }
}
