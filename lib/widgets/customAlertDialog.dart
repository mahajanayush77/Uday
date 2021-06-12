import 'package:flutter/material.dart';
import '../constants.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String action;
  CustomAlertDialog({
    required this.title,
    required this.action,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(
        content,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kAccentColor),
            textStyle: MaterialStateProperty.all(kBodyStyle),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Text(action),
        )
      ],
    );
  }
}
