import 'package:flutter/material.dart';
import '../constants.dart';

class CustomSlider extends StatefulWidget {
  final int max;
  final int min;
  final int initialVal;
  final bool Function(int) onChanged;
  CustomSlider(
    this.max,
    this.min,
    this.onChanged, {
    this.initialVal = 0,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  var isInit = true;
  double _sliderVal = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    if (isInit) {
      _sliderVal = widget.initialVal.toDouble();
      isInit = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.min.toString(),
          style: kSubheadingStyle,
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.blueGrey[300],
              inactiveTrackColor: Colors.blueGrey[200],
              thumbColor: kAccentColor,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 15.0,
                disabledThumbRadius: 15.0,
              ),
              trackHeight: 10.0,
              overlayColor: kPrimaryColor.withAlpha(32),
              inactiveTickMarkColor: Colors.blueGrey[300],
              valueIndicatorColor: kAccentColor.withOpacity(0.7),
            ),
            child: Slider(
              min: widget.min.toDouble(),
              max: widget.max.toDouble(),
              divisions: widget.max.toInt(),
              value: _sliderVal,
              label: _sliderVal.ceil().toString(),
              onChanged: (double v) {
                if (widget.onChanged(v.toInt())) {
                  setState(() {
                    _sliderVal = v;
                    print(_sliderVal);
                  });
                }
              },
            ),
          ),
        ),
        Text(
          widget.max.toString(),
          style: kSubheadingStyle,
        ),
      ],
    );
  }
}
