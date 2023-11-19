import 'package:flutter/material.dart';
import 'package:orbit/components/shimmer/shimmer.dart';

class ArrivingShimmer extends StatefulWidget {
  const ArrivingShimmer({super.key});

  @override
  State<ArrivingShimmer> createState() => _ArrivingShimmerState();
}

class _ArrivingShimmerState extends State<ArrivingShimmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Shimmer(
              width: 88,
              height: 82,
            ),
          ),
        ],
      ),
    );
  }
}
