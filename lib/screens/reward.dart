import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/bottomButton.dart';
import '../widgets/emoji.dart';

class RewardScreen extends StatelessWidget {
  static const routeName = '/reward';

  @override
  Widget build(BuildContext context) {
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
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return EmojiButton(
                        title: 'Ice Cream',
                        emoji: '🍦',
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
