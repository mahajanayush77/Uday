import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../widgets/sliderQuestion.dart';
import '../providers/rewards.dart';
import '../providers/tasks.dart';
import '../models/problem.dart';
import '../widgets/bottomButton.dart';
import '../constants.dart';
import '../screens/challenge.dart';
import '../widgets/customAlertDialog.dart';

class TriageScreen extends StatefulWidget {
  static const routeName = '/triage';

  @override
  _TriageScreenState createState() => _TriageScreenState();
}

class _TriageScreenState extends State<TriageScreen> {
  var _isInit = true;
  late ProblemDetails _problem; // will be initialised later
  int _selectedLevel = 1;
  int _idealLevel = 0;
  int _initialLevel = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final params =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _problem = getProblemDetails(params['problem'] as Problem);

      if (params.containsKey('initialLevel')) {
        setState(() {
          _initialLevel = params['initialLevel'] as int;
        });
      }

      Provider.of<Rewards>(context, listen: false)
          .fetchAndSetRewards()
          .whenComplete(() => _isInit = false);
      Provider.of<Tasks>(context, listen: false)
          .fetchAndSetTasks()
          .whenComplete(() {
        _isInit = false;
      });
    }
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
                  SliderQuestion(
                    ques: 'How ${_problem.adjective} are you ?',
                    min: 1,
                    max: 10,
                    initialVal: _initialLevel,
                    onChanged: (val) {
                      if (_idealLevel > val) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomAlertDialog(
                            title: 'Oops!',
                            action: 'OK',
                            content:
                                'Your ideal ${_problem.noun.toLowerCase()} level cannot be more than your actual ${_problem.noun.toLowerCase()} level.',
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
                  SliderQuestion(
                    ques: 'Select an ideal ${_problem.noun} level',
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
              onPressed: () {
                if (_idealLevel >= _selectedLevel) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        title: 'Oops!',
                        action: 'OK',
                        content:
                            'Please pick an ideal ${_problem.noun.toLowerCase()} level that is realistically lower than your actual ${_problem.noun.toLowerCase()} level.',
                      );
                    },
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    ChallengeScreen.routeName,
                    arguments: <String, dynamic>{
                      'problem': _problem,
                      'idealLevel': _idealLevel,
                      'actualLevel': _selectedLevel,
                    },
                  );
                }
              },
              title: 'NEXT',
            ),
          ],
        ),
      ),
    );
  }
}
