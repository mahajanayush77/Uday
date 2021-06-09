import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uday/providers/tasks.dart';
import '../models/problem.dart';
import '../screens/triage.dart';
import '/constants.dart';
import '../widgets/emoji.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Tasks>(context, listen: false)
          .fetchAndSetTasks()
          .whenComplete(() {
        _isInit = false;
      });
    }
  }

  final double width = 160.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        color: kPrimaryColor,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: SvgPicture.asset(
                      'assets/images/solution.svg',
                      alignment: Alignment.bottomCenter,
                      height: 400,
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        'How are you feeling ?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EmojiButton(
                        title: 'Anxious',
                        emoji: '😰',
                        width: width,
                        onPressed: () => Navigator.pushNamed(
                            context, TriageScreen.routeName,
                            arguments: Problem.Anxiety),
                      ),
                      EmojiButton(
                        title: 'Stressed',
                        emoji: '😫',
                        width: width,
                        onPressed: () => Navigator.pushNamed(
                            context, TriageScreen.routeName,
                            arguments: Problem.Stress),
                      ),
                      EmojiButton(
                        title: 'Depressed',
                        emoji: '😞',
                        width: width,
                        onPressed: () => Navigator.pushNamed(
                            context, TriageScreen.routeName,
                            arguments: Problem.Depression),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
