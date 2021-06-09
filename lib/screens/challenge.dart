import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday/models/problem.dart';
import 'package:uday/providers/tasks.dart';
import '../constants.dart';
import '../widgets/bottomButton.dart';
import '../widgets/emoji.dart';

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
  Set<Tasks> _selectedTasks = {};

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
    final tasks = Provider.of<Tasks>(context, listen: false)
        .tasks
        .where((t) => t.type.contains(_problem.type))
        .toList();
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
                          '${_actualLevel - _idealLevel} Credit(s) remaining',
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
                        return EmojiButton(
                            title: task.title,
                            emoji: task.emoji,
                            subTitle: '${task.credits} Anxiety Credit',
                            onPressed: () {});
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 1.0,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
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
