import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import '../database/database.dart';
import '../screens/checkBack.dart';
import '../screens/schedule.dart';
import '../providers/rewards.dart';
import '../screens/reward.dart';
import '../providers/tasks.dart';
import './screens/triage.dart';
import './constants.dart';
import './screens/home.dart';
import './screens/challenge.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
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
            ],
            child: MaterialApp(
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
                child: HomePage(),
              ),
              routes: {
                HomePage.routeName: (ctx) => HomePage(),
                TriageScreen.routeName: (ctx) => TriageScreen(),
                ChallengeScreen.routeName: (ctx) => ChallengeScreen(),
                RewardScreen.routeName: (ctx) => RewardScreen(),
                ScheduleScreen.routeName: (ctx) => ScheduleScreen(),
                CheckBack.routeName: (ctx) => CheckBack(),
              },
            ),
          )
        : MaterialApp(
            home: Container(
              color: kPrimaryColor,
              child: Container(),
            ),
          );
  }
}
