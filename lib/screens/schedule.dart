import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/customAlertDialog.dart';
import '../widgets/emoji.dart';
import '../widgets/bottomButton.dart';
import '../constants.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = 'schedule';

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
                    'Schedule a time for spending your anxiety credits on the tasks, and check back with us! '
                    'We will help you revaluate your anxiety levels again.',
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
            onPressed: () {},
            title: 'START CHALLENGE',
          ),
        ],
      ),
    ));
  }
}
