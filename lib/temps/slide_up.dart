import 'package:flutter/material.dart';

class SlidingUpPanel extends StatefulWidget {
  final double maxHeight;
  final double minHeight;
  final Widget panel;
  final Widget body;

  SlidingUpPanel({
    required this.maxHeight,
    required this.minHeight,
    required this.panel,
    required this.body,
  });

  @override
  _SlidingUpPanelState createState() => _SlidingUpPanelState();
}

class _SlidingUpPanelState extends State<SlidingUpPanel> {
  double _currentHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.body,
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                _currentHeight -= details.primaryDelta!;
                if (_currentHeight < widget.minHeight) {
                  _currentHeight = widget.minHeight;
                } else if (_currentHeight > widget.maxHeight) {
                  _currentHeight = widget.maxHeight;
                }
              });
            },
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                // Swiped down, close the panel
                _currentHeight = widget.minHeight;
              } else {
                // Swiped up, open the panel
                _currentHeight = widget.maxHeight;
              }
              setState(() {});
            },
            child: Container(
              height: _currentHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: widget.panel,
            ),
          ),
        ),
      ],
    );
  }
}
