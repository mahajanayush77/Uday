import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/CustomSlider.dart';

class SliderQuestion extends StatelessWidget {
  final String ques;
  final int max;
  final int min;
  final bool Function(int) onChanged;
  final int initialVal;

  SliderQuestion({
    required this.ques,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.initialVal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ques,
          style: kHeadingStyle,
        ),
        CustomSlider(
          max: max,
          min: min,
          onChanged: onChanged,
          initialVal: initialVal,
        ),
      ],
    );
  }
}
