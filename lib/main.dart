import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uday/providers/tasks.dart';
import './screens/triage.dart';
import './constants.dart';
import './screens/home.dart';
import './screens/challenge.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Tasks()),
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
          TriageScreen.routeName: (ctx) => TriageScreen(),
          ChallengeScreen.routeName: (ctx) => ChallengeScreen(),
        },
      ),
    );
  }
}
