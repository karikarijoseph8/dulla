import 'package:flutter/material.dart';

// const double _sheetHeight = 300.0;

// class UberBottomSheet extends StatefulWidget {
//   @override
//   _UberBottomSheetState createState() => _UberBottomSheetState();
// }

// class _UberBottomSheetState extends State<UberBottomSheet> {
//   bool _isExpanded = false;

//   void _toggleSheet() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Uber Bottom Sheet Example'),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: _toggleSheet,
//               child: Text('Toggle Bottom Sheet'),
//             ),
//           ),
//           AnimatedPositioned(
//             duration: Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             bottom: _isExpanded ? 0 : -_sheetHeight + 50.0,
//             left: 0,
//             right: 0,
//             height: _sheetHeight,
//             child: GestureDetector(
//               onTap: _toggleSheet,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(16),
//                     topRight: Radius.circular(16),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.symmetric(vertical: 8),
//                       height: 4,
//                       width: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(
//                         'Uber-like Bottom Sheet Content',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

const double _sheetHeight = 300.0;

class UberBottomSheet extends StatefulWidget {
  @override
  _UberBottomSheetState createState() => _UberBottomSheetState();
}

class _UberBottomSheetState extends State<UberBottomSheet> {
  bool _isExpanded = false;

  void _toggleSheet() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
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
          if (_isExpanded) // Conditionally render the bottom sheet
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              //curve: Curves.linear,
              bottom: 0,
              left: 0,
              right: 0,
              height: _sheetHeight,
              child: GestureDetector(
                onTap: _toggleSheet,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
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
            ),
        ],
      ),
    );
  }
}
