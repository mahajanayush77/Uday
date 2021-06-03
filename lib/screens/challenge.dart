import 'package:flutter/material.dart';
import 'package:uday/constants.dart';
import 'package:uday/widgets/bottomButton.dart';

class ChallengeScreen extends StatelessWidget {
  static const routeName = '/challenge';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('The Challenge!'),
          centerTitle: true,
          backgroundColor: kAccentColor,
          elevation: 10.0,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Your extra anxiety levels are converted into credits!',
                      style: kBodyStyle,
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          'Current Anxiety - Ideal Anxiety = Anxiety Credits',
                          style: kBodyStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Text(
                      '''Your challenge is to spend all your anxiety credits on any of the task(s), before the end of the day.''',
                      style: kBodyStyle,
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Divider(
                      thickness: 1.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Available Tasks',
                          style: kSubheadingStyle,
                        ),
                        Text(
                          '3 Credits remaining',
                          style: kBodyStyle,
                        ),
                      ],
                    ),
                    Flexible(
                        fit: FlexFit.loose,
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    Container(),
                            itemCount: 1)),
                  ],
                ),
              ),
            ),
            BottomButton(onPressed: () {}, title: 'NEXT'),
          ],
        ),
      ),
    );
  }
}
