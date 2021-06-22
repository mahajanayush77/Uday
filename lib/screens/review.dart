import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/challenge.dart';
import '../providers/challenges.dart';
import '../screens/triage.dart';
import '../screens/home.dart';
import '../widgets/CustomSlider.dart';
import '../widgets/bottomButton.dart';
import '../widgets/customActionButton.dart';
import '../widgets/customAlertDialog.dart';

class ReviewScreen extends StatefulWidget {
  static const routeName = '/review';

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  var _isInit = true;
  var _actualLevel = 0;
  Challenge? _challenge;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _challenge = ModalRoute.of(context)!.settings.arguments as Challenge?;
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAccentColor,
          title: Text('Review'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 25.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please rate your ${_challenge!.problem.noun.toLowerCase()} levels after completing your tasks.',
                    style: kBodyStyle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  CustomSlider(
                    max: 10,
                    min: 0,
                    onChanged: (val) {
                      _actualLevel = val;
                      return true;
                    },
                    initialVal: 0,
                  ),
                ],
              ),
            ),
            BottomButton(
              title: 'NEXT',
              onPressed: () async {
                try {
                  await Provider.of<Challenges>(context, listen: false)
                      .endChallenge(
                    _challenge!.id,
                    _actualLevel,
                  ); // end challenge

                  var dialogText = '';
                  var dialogActions = <Widget>[];

                  final okayButton = CustomActionButton(
                    action: 'OK',
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        HomePage.routeName,
                        (route) => false,
                      );
                    },
                  );

                  final tryAgainButton = CustomActionButton(
                    action: 'Try Again',
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed(
                        TriageScreen.routeName,
                        arguments: <String, dynamic>{
                          'problem': _challenge!.problem.type,
                          'initialLevel': _actualLevel,
                        },
                      );
                    },
                  );

                  final takeABreakButton = CustomActionButton(
                    action: 'Take a break',
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        HomePage.routeName,
                        (route) => false,
                      );
                    },
                  );

                  if (_actualLevel < 1) {
                    dialogText =
                        'Congratulations on getting your ${_challenge!.problem.noun} levels to zero! You rock 🤘';
                    dialogActions.add(okayButton);
                  } else if (_actualLevel < _challenge!.idealLevel) {
                    dialogText =
                        'Well done! Your ${_challenge!.problem.noun} levels seem better than ideal.';
                    dialogActions.addAll([tryAgainButton, takeABreakButton]);
                  } else if (_actualLevel == _challenge!.idealLevel) {
                    dialogText =
                        'Good job on completing all your tasks! You are getting better.';
                    dialogActions.addAll([tryAgainButton, takeABreakButton]);
                  } else if (_actualLevel > _challenge!.idealLevel &&
                      _actualLevel < _challenge!.initialLevel) {
                    dialogText =
                        'Don\'t give up! You have made great effort in completing your tasks.';
                    dialogActions.addAll([tryAgainButton, takeABreakButton]);
                  } else if (_actualLevel < 7) {
                    dialogText =
                        'We take a few steps forward, some backwards. But most importantly we are progressing!';
                    dialogActions.addAll([tryAgainButton, takeABreakButton]);
                  } else {
                    dialogText =
                        'Progress takes time, you\'re putting in effort and that\'s all that matters! Do talk to someone if your ${_challenge!.problem.noun} persists 💪';
                    dialogActions.addAll([tryAgainButton, takeABreakButton]);
                  }

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Review'),
                        content: Text(dialogText),
                        actions: dialogActions,
                      );
                    },
                  );
                } catch (e) {
                  print(e);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        title: 'Oops!',
                        action: 'OK',
                        content: 'An unexpected error occurred.',
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
