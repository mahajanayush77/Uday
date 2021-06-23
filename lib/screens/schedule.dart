import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/challenge.dart';
import '../providers/challenges.dart';
import '../models/problem.dart';
import '../models/reward.dart';
import '../models/task.dart';
import '../widgets/customAlertDialog.dart';
import '../widgets/emoji.dart';
import '../widgets/bottomButton.dart';
import '../constants.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = 'schedule';

  final Future<void> Function(DateTime, String, String) scheduleNotification;
  ScheduleScreen(this.scheduleNotification);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  TimeOfDay _scheduledTime = TimeOfDay(
    hour: DateTime.now().hour + 1,
    minute: DateTime.now().minute,
  );

  String _formatTime(TimeOfDay time) {
    final today = DateTime.now();
    final dateTime = DateTime(
      today.day,
      today.month,
      today.year,
      time.hour,
      time.minute,
    );
    return DateFormat.jm().format(dateTime);
  }

  var _isInit = true;
  late Reward _selectedReward;
  late ProblemDetails _problem;
  late Set<Task> _selectedTasks;
  late int _initialLevel;
  late int _idealLevel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final params =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _problem = params['problem'] as ProblemDetails;
      _selectedTasks = params['tasks'] as Set<Task>;
      _initialLevel = params['initialLevel'] as int;
      _idealLevel = params['idealLevel'] as int;
      _selectedReward = params['reward'] as Reward;
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Schedule'),
          centerTitle: true,
          backgroundColor: kAccentColor,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Schedule a time for spending your ${_problem.noun.toLowerCase()} credits on the tasks, and check back with us! '
                      'We will help you revaluate your ${_problem.noun.toLowerCase()} levels again.',
                      style: kBodyStyle,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Divider(
                      thickness: 1.0,
                    ),
                    Text(
                      'Set a time',
                      style: kSubheadingStyle,
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    EmojiButton(
                      title: '${_formatTime(_scheduledTime)}',
                      emoji: '📅',
                      subTitle: 'Select to change time',
                      onPressed: () async {
                        try {
                          final selectedTime = await showTimePicker(
                            context: context,
                            initialTime: _scheduledTime,
                          );
                          if (selectedTime!.hour < TimeOfDay.now().hour ||
                              (selectedTime.hour == TimeOfDay.now().hour &&
                                  selectedTime.minute <=
                                      TimeOfDay.now().minute + 15)) {
                            final minTimeOfDay = _formatTime(
                              TimeOfDay(
                                hour: TimeOfDay.now().hour,
                                minute: TimeOfDay.now().minute + 15,
                              ),
                            );

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlertDialog(
                                    title: 'Oops!',
                                    action: 'OK',
                                    content:
                                        'The scheduled time could be past $minTimeOfDay !');
                              },
                            );
                          } else {
                            setState(() {
                              _scheduledTime = selectedTime;
                            });
                          }
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAlertDialog(
                                title: 'Oops!',
                                action: 'OK',
                                content: 'An unexpected error occurred!',
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            BottomButton(
              onPressed: () {
                final now = TimeOfDay.now();
                final _notValid = now.hour > _scheduledTime.hour ||
                    (now.hour == _scheduledTime.hour &&
                        now.minute > _scheduledTime.minute);
                if (_notValid) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        title: 'Oops!',
                        action: 'OK',
                        content:
                            'You have picked a time that is already over, please pick another time to check back with us.',
                      );
                    },
                  );
                } else {
                  final dateTimeNow = DateTime.now();
                  final reminderDateTime = DateTime(
                    dateTimeNow.year,
                    dateTimeNow.month,
                    dateTimeNow.day,
                    _scheduledTime.hour,
                    _scheduledTime.minute,
                  );

                  final newChallenge = Challenge(
                    idealLevel: _idealLevel,
                    initialLevel: _initialLevel,
                    tasks: _selectedTasks,
                    reward: _selectedReward,
                    remindAt: reminderDateTime,
                    problem: _problem,
                  );

                  Provider.of<Challenges>(context, listen: false)
                      .create(newChallenge)
                      .then((_) {
                    return widget.scheduleNotification(
                      reminderDateTime,
                      'Check In',
                      'Let\'s revaluate your ${_problem.noun.toLowerCase()} levels again!',
                    );
                  }).then((_) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (route) => false,
                    );
                  }).catchError((err) {
                    print(err);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                            title: 'Oops!',
                            action: 'OK',
                            content: 'An unexpected error occurred!',
                          );
                        });
                    throw (err);
                  });
                }
              },
              title: 'START CHALLENGE',
            ),
          ],
        ),
      ),
    );
  }
}
