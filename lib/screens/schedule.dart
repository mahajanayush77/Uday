import 'package:flutter/material.dart';
import '../constants.dart';

class ScheduleScreen extends StatelessWidget {
  static const routeName = 'schedule';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        centerTitle: true,
        backgroundColor: kAccentColor,
      ),
      body: Container(),
    ));
  }
}
