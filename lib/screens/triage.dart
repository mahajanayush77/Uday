import 'package:flutter/material.dart';
import 'package:uday/widgets/CustomSlider.dart';
import '../constants.dart';

class TriageScreen extends StatefulWidget {
  static const routeName = '/triage';

  @override
  _TriageScreenState createState() => _TriageScreenState();
}

class _TriageScreenState extends State<TriageScreen> {
  int _selectedLevel = 1;
  int _idealLevel = 0;

  Widget _buildQuestion(
    String ques,
    int min,
    int max,
    int initialVal,
    bool Function(int) onChanged,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ques,
          style: kHeadingStyle,
        ),
        CustomSlider(
          max,
          min,
          onChanged,
          initialVal: 0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 10.0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildQuestion(
                'How anxious are you ?',
                1,
                10,
                1,
                (val) {
                  setState(() {
                    _selectedLevel = val;
                  });
                  return true;
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              _buildQuestion(
                'Select an ideal anxiety level',
                0,
                _selectedLevel,
                1,
                (val) {
                  setState(() {
                    _idealLevel = val;
                  });
                  return true;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
