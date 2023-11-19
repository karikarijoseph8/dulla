import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   bool _isBottomSheetVisible = false;

//   void _toggleBottomSheetVisibility() {
//     setState(() {
//       _isBottomSheetVisible = !_isBottomSheetVisible;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Flutter Bottom Sheet')),
//       body: Stack(
//         children: [
//           // Main content of the screen
//           Center(
//             child: Text(
//               'Main Content',
//               style: TextStyle(fontSize: 24),
//             ),
//           ),
//           // Toggle Button
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 140, // Adjust the position as needed
//             child: ElevatedButton(
//               onPressed: _toggleBottomSheetVisibility,
//               child: Text(_isBottomSheetVisible
//                   ? 'Hide Bottom Sheet'
//                   : 'Show Bottom Sheet'),
//             ),
//           ),
//           // Bottom sheet
//           _isBottomSheetVisible
//               ? Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: Container(
//                     color: Colors.white,
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'Bottom Sheet Content',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         SizedBox(height: 16),
//                         ElevatedButton(
//                           onPressed: _toggleBottomSheetVisibility,
//                           child: Text('Hide Bottom Sheet'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : SizedBox
//                   .shrink(), // Empty container when the bottom sheet is hidden
//         ],
//       ),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isPanelOpen = false;
  final _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliding Up Panel Example'),
      ),
      body: Stack(
        children: [
          // Content below the panel
          Container(
            color: Colors.white, // Set your background color here
          ),
          if (_isPanelOpen) // Conditionally render the SlidingUpPanel based on visibility state
            SlidingUpPanel(
              controller: _panelController,
              onPanelOpened: () {
                setState(() {
                  _isPanelOpen = true;
                });
              },
              onPanelClosed: () {
                setState(() {
                  _isPanelOpen = false;
                });
              },
              panel: Center(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Sliding Up Panel Content',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              maxHeight: 400, // Set the maximum height of the panel here
              minHeight: 60, // Set the minimum height of the panel here
              body:
                  Container(), // Empty container or your main content goes here
            ),
          // Button to toggle the panel visibility
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                if (_isPanelOpen) {
                  _panelController.close();
                } else {
                  _panelController.open();
                }
              },
              child: Icon(_isPanelOpen
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_up),
            ),
          ),
          // Button to interact with the panel (outside the panel)
          Positioned(
            bottom: 100, // Adjust the position as needed
            right: 20, // Adjust the position as needed
            child: ElevatedButton(
              onPressed: () {
                // Add your button functionality here to interact with the panel
              },
              child: Text('Interact with Panel'),
            ),
          ),
        ],
      ),
    );
  }
}
