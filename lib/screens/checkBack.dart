import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../screens/review.dart';
import '../widgets/customActionButton.dart';
import '../models/challenge.dart';
import '../constants.dart';
import '../widgets/bottomButton.dart';
import '../widgets/emoji.dart';

class CheckBack extends StatelessWidget {
  static const routeName = '/check-back';
  final Challenge? challenge;
  CheckBack({
    required this.challenge,
  });

  // Use only for non-empty strings.
  String _capitaliseFirstChar(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final creditsProblemWord = _capitaliseFirstChar(challenge!.problem.noun);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAccentColor,
          title: Text('Check Back'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 80.0,
                horizontal: 30.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: SvgPicture.asset(
                      'assets/images/yoga.svg',
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 25.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Objective',
                        style: kHeadingStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Spend ${challenge!.initialLevel - challenge!.idealLevel} stress credits on',
                        style: kBodyStyle,
                      ),
                      Divider(
                        thickness: 1.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  ListView.separated(
                    itemCount: challenge!.tasks.length,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final task = challenge!.tasks.toList()[index];
                      return EmojiButton(
                        title: task.title,
                        emoji: task.emoji,
                        subTitle: '${task.credits} $creditsProblemWord Credit',
                        onPressed: () {},
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 2.0,
                      );
                    },
                  ),
                ],
              ),
            ),
            BottomButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Great Job ${challenge!.reward.emoji}'),
                      content: Text(
                          'Reward yourself with ${challenge!.reward.title} for the hard work you have put in!'),
                      actions: [
                        CustomActionButton(
                          action: 'OK',
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(
                              context,
                              ReviewScreen.routeName,
                              arguments: challenge,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              title: 'I\'m Done!',
            ),
          ],
        ),
      ),
    );
  }
}
