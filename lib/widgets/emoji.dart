import 'package:flutter/material.dart';

class EmojiButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final String emoji;
  final double width;
  final String subTitle;
  EmojiButton({
    required this.title,
    required this.emoji,
    required this.onPressed,
    this.width = double.infinity,
    this.subTitle = "",
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
      child: Container(
        height: 40.0,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(emoji,
                    style: TextStyle(fontSize: 16.0, color: Colors.black)),
                SizedBox(
                  width: 20.0,
                ),
                Text(title,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      letterSpacing: 1.2,
                    )),
              ],
            ),
            Text(subTitle,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                  letterSpacing: 1.2,
                )),
          ],
        ),
      ),
    );
  }
}
