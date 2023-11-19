import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    // Start the blinking animation
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _isVisible = !_isVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blinking Dots Example'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: Text(
                '...',
                style: TextStyle(fontSize: 24),
              ),
            ),
            //SizedBox(width: 8),
            Text(
              'Hello World!',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
