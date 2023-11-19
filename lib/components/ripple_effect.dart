import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RippleAnimation extends StatelessWidget {
  final LatLng center; // Center of the ripple
  final int numberOfRipples;
  final Duration duration;

  RippleAnimation({
    required this.center,
    this.numberOfRipples = 3,
    this.duration = const Duration(seconds: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(numberOfRipples, (index) {
        final delay = index * (duration.inMilliseconds / numberOfRipples);
        return AnimatedPositioned(
          duration: duration,
          left: center.longitude - 0.002 * index,
          top: center.latitude - 0.002 * index,
          child: AnimatedOpacity(
            duration: duration,
            opacity: 0,
            curve: Curves.easeOut,
            onEnd: () {
              // Remove the circle when the animation completes
            },
            child: Container(
              width: 0.004 * index,
              height: 0.004 * index,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
