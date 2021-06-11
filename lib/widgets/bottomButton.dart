import 'package:flutter/material.dart';
import '../constants.dart';

class BottomButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  BottomButton({
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 10.0),
        width: double.infinity,
        color: Colors.grey[200],
        height: 50.0,
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: kSubheadingStyle,
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kAccentColor)),
        ),
      ),
    );
  }
}
