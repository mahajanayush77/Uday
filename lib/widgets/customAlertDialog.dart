import 'package:flutter/material.dart';
import './customActionButton.dart';

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
        CustomActionButton(
          action: action,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
