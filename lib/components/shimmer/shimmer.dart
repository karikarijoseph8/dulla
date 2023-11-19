import 'package:flutter/material.dart';

class Shimmer extends StatelessWidget {
  const Shimmer({Key? key, this.height, this.width, this.defaultPadding = 16})
      : super(key: key);

  final double? height, width;
  final double defaultPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.all(Radius.circular(defaultPadding))),
    );
  }
}

class CircleShimmer extends StatelessWidget {
  const CircleShimmer({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Color(0xFF2967FF).withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}
