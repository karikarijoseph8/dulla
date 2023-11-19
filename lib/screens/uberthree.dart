import 'package:flutter/material.dart';

const double _sheetHeight = 300.0;
const double _sheetWidth = 300.0;

class UberBottomSheet extends StatefulWidget {
  @override
  _UberBottomSheetState createState() => _UberBottomSheetState();
}

class _UberBottomSheetState extends State<UberBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust the duration to 500ms
    );
  }

  void _toggleSheet() {
    setState(() {
      if (_isExpanded) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uber Bottom Sheet Example'),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _toggleSheet,
              child: Text('Toggle Bottom Sheet'),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: _isExpanded ? 0 : -_sheetHeight + 50.0,
                left: 0,
                right: 0,
                height: _sheetHeight,
                child: GestureDetector(
                  onTap: _toggleSheet,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          height: 4,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Uber-like Bottom Sheet Content',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class UberBottomSheetLeft extends StatefulWidget {
  @override
  _UberBottomSheetLeftState createState() => _UberBottomSheetLeftState();
}

class _UberBottomSheetLeftState extends State<UberBottomSheetLeft>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  void _toggleSheet() {
    setState(() {
      if (_isExpanded) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uber Bottom Sheet Left Example'),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _toggleSheet,
              child: Text('Toggle Bottom Sheet'),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final width = _sheetWidth *
                  _controller.value; // Adjust width based on animation value
              return Positioned(
                left: _isExpanded ? 0 : -width + 50.0,
                top: 0,
                bottom: 0,
                width: width,
                child: GestureDetector(
                  onTap: _toggleSheet,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(_isExpanded ? 0 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(3, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          height: 4,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Uber-like Bottom Sheet Left Content',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class UberBottomSheetRight extends StatefulWidget {
  @override
  _UberBottomSheetRightState createState() => _UberBottomSheetRightState();
}

class _UberBottomSheetRightState extends State<UberBottomSheetRight>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  void _toggleSheet() {
    setState(() {
      if (_isExpanded) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uber Bottom Sheet Right Example'),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _toggleSheet,
              child: Text('Toggle Bottom Sheet'),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final width = _sheetWidth *
                  _controller.value; // Adjust width based on animation value
              return Positioned(
                right: _isExpanded ? 0 : -width + 50.0,
                top: 0,
                bottom: 0,
                width: width,
                child: GestureDetector(
                  onTap: _toggleSheet,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(_isExpanded ? 0 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(-3, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          height: 4,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Uber-like Bottom Sheet Right Content',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ThreeUberBottomSheetsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Three Uber-like Bottom Sheets Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UberBottomSheet(),
                ));
              },
              child: Text('Open Bottom Sheet'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UberBottomSheetLeft(),
                ));
              },
              child: Text('Open Left Bottom Sheet'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UberBottomSheetRight(),
                ));
              },
              child: Text('Open Right Bottom Sheet'),
            ),
          ],
        ),
      ),
    );
  }
}
