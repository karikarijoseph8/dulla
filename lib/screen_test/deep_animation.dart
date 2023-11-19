import 'dart:async';

import 'package:flutter/material.dart';

class ShadeBreathingAnimation extends StatefulWidget {
  @override
  _ShadeBreathingAnimationState createState() =>
      _ShadeBreathingAnimationState();
}

class _ShadeBreathingAnimationState extends State<ShadeBreathingAnimation> {
  List<Color> colorShades = [
    Colors.blue[50]!, // Light shade of blue
    Colors.blue[100]!, // Slightly darker shade
    Colors.blue[200]!, // Medium shade
    Colors.blue[300]!, // Slightly darker shade
    Colors.blue[400]!, // Darker shade
  ];

  int _currentColorIndex = 0;

  @override
  void initState() {
    super.initState();
    _startColorAnimation();
  }

  void _cycleColor() {
    setState(() {
      _currentColorIndex = (_currentColorIndex + 1) % colorShades.length;
    });
  }

  void _startColorAnimation() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      _cycleColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        width: 100,
        height: 100,
        color: colorShades[_currentColorIndex],
      ),
    );
  }
}
