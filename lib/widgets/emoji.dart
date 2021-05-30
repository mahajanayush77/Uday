import 'package:flutter/material.dart';

class EmojiButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final String emoji;
  EmojiButton(this.title, this.emoji, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
        ),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      child: Container(
        width: 160.0,
        child: Row(
          children: [
            Text(emoji),
            SizedBox(
              width: 20.0,
            ),
            Text(
              title,
            ),
          ],
        ),
      ),
    );
  }
}
