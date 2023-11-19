import 'package:flutter/material.dart';

class MyCheckboxScreen extends StatefulWidget {
  @override
  _MyCheckboxScreenState createState() => _MyCheckboxScreenState();
}

class _MyCheckboxScreenState extends State<MyCheckboxScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Checkbox'),
      ),
      body: Center(
        child: Checkbox(
          value: _isChecked,
          onChanged: (newValue) {
            setState(() {
              _isChecked = newValue ?? false;
            });
          },
        ),
      ),
    );
  }
}
