import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday/providers/rewards.dart';
import '../constants.dart';
import '../widgets/bottomButton.dart';
import '../widgets/emoji.dart';

class RewardScreen extends StatelessWidget {
  static const routeName = '/reward';

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
                    'After spending your anxiety credits on the tasks, you are encouraged to reward yourself with something! \n'
                    'This would help you to tackle anxiety in an actionable manner in future.',
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
                      return EmojiButton(
                        title: reward.title,
                        emoji: reward.emoji,
                        onPressed: () {},
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
          BottomButton(onPressed: () {}, title: 'NEXT'),
        ],
      ),
    ));
  }
}
