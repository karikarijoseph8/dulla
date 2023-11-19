import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Taxi3DDrawing extends StatefulWidget {
  @override
  State<Taxi3DDrawing> createState() => _Taxi3DDrawingState();
}

class _Taxi3DDrawingState extends State<Taxi3DDrawing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3D-Like Taxi Drawing'),
      ),
      body: SpinKitRotatingCircle(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
