import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/schedule.dart';
import '../models/problem.dart';
import '../models/task.dart';
import '../widgets/customAlertDialog.dart';
import '../models/reward.dart';
import '../providers/rewards.dart';
import '../constants.dart';
import '../widgets/bottomButton.dart';
import '../widgets/emoji.dart';

class RewardScreen extends StatefulWidget {
  static const routeName = '/reward';

  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  var _isInit = true;
  Reward? _selectedReward;
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
      _selectedTasks = params['selectedTasks'] as Set<Task>;
      _initialLevel = params['initialLevel'] as int;
      _idealLevel = params['idealLevel'] as int;
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final rewards = Provider.of<Rewards>(context, listen: false).rewards;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Reward'),
        backgroundColor: kAccentColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
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
                    'After spending your ${_problem.noun} credits on the tasks, you are encouraged to reward yourself with something! \n'
                    'This would help you to tackle ${_problem.noun} in an actionable manner in future.',
                    style: kBodyStyle,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Divider(
                    thickness: 1.0,
                  ),
                  Text(
                    'Pick a reward',
                    style: kSubheadingStyle,
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  ListView.separated(
                    itemCount: rewards.length,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final reward = rewards[index];
                      bool selected = _selectedReward != null &&
                          _selectedReward!.id == reward.id;
                      return EmojiButton(
                        title: reward.title,
                        emoji: reward.emoji,
                        backgroundColor:
                            selected ? Colors.green[200] : Colors.grey[200],
                        onPressed: () {
                          setState(() {
                            _selectedReward = reward;
                          });
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      height: 4.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
              onPressed: () {
                if (_selectedReward != null) {
                  print(_selectedReward!.title);
                  Navigator.pushNamed(
                    context,
                    ScheduleScreen.routeName,
                    arguments: <String, dynamic>{
                      'problem': _problem,
                      'idealLevel': _idealLevel,
                      'initialLevel': _initialLevel,
                      'tasks': _selectedTasks,
                      'reward': _selectedReward,
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        title: 'Oops!',
                        action: 'OK',
                        content:
                            'Positive reinforcement is necessary for effectively dealing with ${_problem.noun.toLowerCase()} in future. Please pick a reward !',
                      );
                    },
                  );
                }
              },
              title: 'NEXT'),
        ],
      ),
    ));
  }
}
