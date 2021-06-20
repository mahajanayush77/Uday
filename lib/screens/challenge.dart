import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tasks.dart';
import '../screens/reward.dart';
import '../constants.dart';
import '../widgets/bottomButton.dart';
import '../widgets/emoji.dart';
import '../models/problem.dart';
import '../models/task.dart';
import '../widgets/customAlertDialog.dart';

class ChallengeScreen extends StatefulWidget {
  static const routeName = '/challenge';
  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  var _isInit = true;
  late ProblemDetails _problem;
  late int _actualLevel;
  late int _idealLevel;
  Set<Task> _selectedTasks = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final params =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _problem = params['problem'] as ProblemDetails;
      _idealLevel = params['idealLevel'] as int;
      _actualLevel = params['actualLevel'] as int;
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context, listen: false).tasks;
    int creditsUsed = _selectedTasks.fold(0, (sum, t) => sum + t.credits);
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
                      'Your extra ${_problem.noun} levels are converted into credits!',
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
                          'Current ${_problem.noun} - Ideal ${_problem.noun} = ${_problem.noun} Credits',
                          style: kBodyStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Text(
                      '''Your challenge is to spend all your ${_problem.noun.toLowerCase()} credits on any of the task(s), before the end of the day.''',
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
                          '${_actualLevel - _idealLevel - creditsUsed} Credit(s) remaining',
                          style: kBodyStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    ListView.separated(
                      itemCount: tasks.length,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final task = tasks[index];
                        final bool alreadySelected = _selectedTasks
                                .where((t) => t.id == task.id)
                                .length >
                            0;
                        return EmojiButton(
                          title: task.title,
                          emoji: task.emoji,
                          subTitle: '${task.credits} Anxiety Credit',
                          backgroundColor: alreadySelected
                              ? Colors.green[200]
                              : Colors.grey[200],
                          onPressed: () {
                            if (alreadySelected) {
                              setState(() {
                                _selectedTasks
                                    .removeWhere((t) => t.id == task.id);
                              });
                            } else {
                              int creditsSelected = 0;
                              if (_selectedTasks.isNotEmpty) {
                                creditsSelected = _selectedTasks.fold(
                                    0, (sum, t) => sum + t.credits);
                              }

                              if ((creditsSelected + task.credits) <=
                                  (_actualLevel - _idealLevel)) {
                                setState(() {
                                  _selectedTasks.add(task);
                                });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomAlertDialog(
                                        title: 'Oops!',
                                        action: 'OK',
                                        content:
                                            'You do not have enough ${_problem.noun.toLowerCase()} credits left.',
                                      );
                                    });
                              }
                            }
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 2.0,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                  ],
                ),
              ),
            ),
            BottomButton(
                onPressed: () {
                  var notValid = _selectedTasks.isEmpty ||
                      creditsUsed != _actualLevel - _idealLevel;
                  if (notValid) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                            title: 'Oops!',
                            action: 'OK',
                            content:
                                'It seems like you have not spent all your ${_problem.noun.toLowerCase()} credits!',
                          );
                        });
                  } else {
                    Navigator.pushNamed(
                      context,
                      RewardScreen.routeName,
                      arguments: <String, dynamic>{
                        'problem': _problem,
                        'selectedTasks': _selectedTasks,
                        'idealLevel': _idealLevel,
                        'initialLevel': _actualLevel,
                      },
                    );
                  }
                },
                title: 'NEXT'),
          ],
        ),
      ),
    );
  }
}
