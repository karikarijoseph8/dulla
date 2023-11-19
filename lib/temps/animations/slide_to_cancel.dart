import 'package:flutter/material.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class SlideToCancelScreen extends StatefulWidget {
  @override
  _SlideToCancelScreenState createState() => _SlideToCancelScreenState();
}

class _SlideToCancelScreenState extends State<SlideToCancelScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isCancelled = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      value: 0.0,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onSlideStart(DragStartDetails details) {
    _animationController.forward();
  }

  void _onSlideUpdate(BuildContext context, DragUpdateDetails details) {
    double dragPercentage = details.localPosition.dx / context.size!.width;
    _animationController.value = dragPercentage;
    if (dragPercentage >= 1.0) {
      _isCancelled = true;
    } else {
      _isCancelled = false;
    }
  }

  void _onSlideEnd(DragEndDetails details) {
    if (_isCancelled) {
      // Handle slide-to-cancel action
      print('Slide-to-cancel action triggered!');
    }
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide to Cancel'),
      ),
      body: GestureDetector(
        onHorizontalDragStart: _onSlideStart,
        onHorizontalDragUpdate: (details) => _onSlideUpdate(context, details),
        onHorizontalDragEnd: _onSlideEnd,
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double slideAmount =
                    constraints.maxWidth * _animationController.value;
                return Positioned(
                  left: slideAmount - constraints.maxWidth,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: constraints.maxWidth,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        'Slide to Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Slide the blue area to the right to cancel.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
