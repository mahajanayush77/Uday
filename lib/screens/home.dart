import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        color: kPrimaryColor,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 20.0,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/solution.svg',
                        alignment: Alignment.bottomCenter,
                        height: 400,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: FittedBox(
                        child: Text(
                          'How are you feeling ?',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 27.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EmojiButton(
                      'Anxious',
                      '😰',
                      () {},
                    ),
                    EmojiButton(
                      'Stressed',
                      '😫',
                      () {},
                    ),
                    EmojiButton(
                      'Depressed',
                      '😞',
                      () {},
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EmojiButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final String emoji;
  EmojiButton(this.title, this.emoji, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onPressed,
      highlightColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      height: 40.0,
      color: Colors.grey.shade300,
      child: Container(
        width: 150.0,
        child: Row(
          children: [
            Text(emoji),
            SizedBox(
              width: 20.0,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
