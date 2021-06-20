import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../widgets/bottomButton.dart';
import '../widgets/emoji.dart';

class CheckBack extends StatelessWidget {
  static const routeName = '/check-back';
  @override
  Widget build(BuildContext context) {
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
                        'Spend 3 stress credits on',
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
                    itemCount: 4,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return EmojiButton(
                        title: 'Meditate',
                        emoji: '🏃',
                        subTitle: '2 Anxiety Credit',
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
              onPressed: () {},
              title: 'I\'m Done!',
            ),
          ],
        ),
      ),
    );
  }
}
