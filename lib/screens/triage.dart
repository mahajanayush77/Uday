import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uday/widgets/bottomButton.dart';
import '../widgets/CustomSlider.dart';
import '../constants.dart';
import 'package:uday/screens/challenge.dart';

class TriageScreen extends StatefulWidget {
  static const routeName = '/triage';

  @override
  _TriageScreenState createState() => _TriageScreenState();
}

class _TriageScreenState extends State<TriageScreen> {
  int _selectedLevel = 1;
  int _idealLevel = 0;
  Widget _buildQuestion({
    required String ques,
    required int min,
    required int max,
    required int initialVal,
    required bool Function(int) onChanged,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ques,
          style: kHeadingStyle,
        ),
        CustomSlider(
          max: max,
          min: min,
          onChanged: onChanged,
          initialVal: initialVal,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAccentColor,
          elevation: 10.0,
          title: Text('Triage'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 40.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildQuestion(
                    ques: 'How anxious are you ?',
                    min: 1,
                    max: 10,
                    initialVal: 1,
                    onChanged: (val) {
                      if (_idealLevel > val) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('Oops!'),
                            content: Text(
                              'Your ideal anxiety level cannot be more than your actual anxiety level.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(kAccentColor),
                                  textStyle:
                                      MaterialStateProperty.all(kBodyStyle),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: Text('OK'),
                              )
                            ],
                          ),
                        );
                        return false;
                      } else {
                        setState(() {
                          _selectedLevel = val;
                        });
                        return true;
                      }
                    },
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  _buildQuestion(
                    ques: 'Select an ideal anxiety level',
                    min: 0,
                    max: _selectedLevel,
                    initialVal: 0,
                    onChanged: (val) {
                      setState(() {
                        _idealLevel = val;
                      });
                      return true;
                    },
                  ),
                ],
              ),
            ),
            BottomButton(
              onPressed: () =>
                  Navigator.pushNamed(context, ChallengeScreen.routeName),
              title: 'NEXT',
            ),
          ],
        ),
      ),
    );
  }
}
