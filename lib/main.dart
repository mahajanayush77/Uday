import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../screens/review.dart';
import '../screens/checkBack.dart';
import '../screens/schedule.dart';
import '../screens/reward.dart';
import './screens/home.dart';
import './screens/triage.dart';
import './screens/challenge.dart';

import '../providers/challenges.dart';
import '../providers/rewards.dart';
import '../providers/tasks.dart';

import './constants.dart';
import '../database/database.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails? notificationAppLaunchDetails;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // portrait orientation
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // setup local notifications
    notificationAppLaunchDetails = (await flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails());

    final initialisationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher_round');

    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: initialisationSettingsAndroid,
      ),
    );

    runApp(MyApp());
  } catch (e) {
    print(e);
    throw e;
  }
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _isInit = true;
  late Database _database;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      connectToDB(DB_NAME).then((database) {
        _database = database;
      }).catchError((err) {
        print(err);
      }).whenComplete(() {
        setState(() {
          _isInit = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_isInit
        ? MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => Tasks(_database)),
              ChangeNotifierProvider(create: (_) => Rewards(_database)),
              ChangeNotifierProvider(create: (_) => Challenges(_database)),
            ],
            child: Consumer<Challenges>(builder: (context, challenges, _) {
              return MaterialApp(
                title: 'Uday',
                theme: ThemeData(
                  primaryColor: kPrimaryColor,
                  accentColor: kAccentColor,
                  textTheme: GoogleFonts.quicksandTextTheme(
                    Theme.of(context).textTheme,
                  ),
                ),
                debugShowCheckedModeBanner: false,
                home: SafeArea(
                  child: challenges.latestChallenge == null
                      ? HomePage()
                      : CheckBack(
                          challenge: challenges.latestChallenge,
                        ),
                ),
                routes: {
                  HomePage.routeName: (ctx) => HomePage(),
                  TriageScreen.routeName: (ctx) => TriageScreen(),
                  ChallengeScreen.routeName: (ctx) => ChallengeScreen(),
                  RewardScreen.routeName: (ctx) => RewardScreen(),
                  ScheduleScreen.routeName: (ctx) =>
                      ScheduleScreen(scheduleNotification),
                  ReviewScreen.routeName: (ctx) => ReviewScreen(),
                },
              );
            }),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Container(
              color: kPrimaryColor,
              child: Container(),
            ),
          );
  }
}

Future initializeTimeZone() async {
  tz.initializeTimeZones();
}

Future<void> scheduleNotification(
    DateTime scheduledTime, String title, String description) async {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'uday_id',
    'uday',
    'Remind people to check in after completing tasks.',
  );

  final platformSpecifics =
      NotificationDetails(android: androidChannelSpecifics);
  await initializeTimeZone();
  var time = tz.TZDateTime.from(
    scheduledTime,
    tz.local,
  );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    description,
    time,
    platformSpecifics,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
  );
}
