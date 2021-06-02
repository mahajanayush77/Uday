import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uday/screens/triage.dart';
import '/constants.dart';
import '../widgets/emoji.dart';

class HomePage extends StatelessWidget {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EmojiButton(
                      'Anxious',
                      '😰',
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TriageScreen())),
                    ),
                    EmojiButton(
                      'Stressed',
                      '😫',
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TriageScreen())),
                    ),
                    EmojiButton(
                      'Depressed',
                      '😞',
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TriageScreen())),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
