import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// class DraggableBottomSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Draggable Bottom Sheet'),
//       ),
//       body: SlidingUpPanel(
//         panelBuilder: (scrollController) => _buildPanel(scrollController),
//         minHeight: 60, // Minimum height of the panel when collapsed
//         maxHeight: MediaQuery.of(context).size.height *
//             0.8, // Maximum height of the panel when fully expanded
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(18.0),
//           topRight: Radius.circular(18.0),
//         ),
//         boxShadow: null, // Customize the shadow appearance if needed
//         parallaxEnabled: true, // Enable parallax effect while dragging
//         parallaxOffset: 0.5, // Customize the parallax offset
//         //duration: Duration(milliseconds: 500), // Duration of the animation
//         isDraggable: true, // Enable/disable dragging
//         renderPanelSheet:
//             true, // If false, hide the rounded corner of the sheet
//         backdropEnabled: true, // Enable/disable the backdrop when panel is open
//         backdropOpacity: 0.5, // Opacity of the backdrop when panel is open
//         backdropColor: Colors.black, // Color of the backdrop
//       ),
//     );
//   }

//   Widget _buildPanel(ScrollController scrollController) {
//     return Container(
//       // Customize the content of the bottom sheet here
//       child: Center(
//         child: Text(
//           'Your content here',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

// class DraggableBottomSheet extends StatefulWidget {
//   @override
//   _DraggableBottomSheetState createState() => _DraggableBottomSheetState();
// }

// class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
//   final PanelController _panelController = PanelController();
//   bool _isPanelOpen = false;

//   void _togglePanel() {
//     _isPanelOpen ? _panelController.close() : _panelController.open();
//     setState(() {
//       _isPanelOpen = !_isPanelOpen;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Draggable Bottom Sheet'),
//       ),
//       body: Stack(children: [
//         Center(
//           child: ElevatedButton(
//             onPressed: _togglePanel,
//             child:
//                 Text(_isPanelOpen ? 'Close Bottom Sheet' : 'Open Bottom Sheet'),
//           ),
//         ),
//         SlidingUpPanel(
//           controller: _panelController,
//           panelBuilder: (scrollController) => _buildPanel(scrollController),
//           minHeight: 60,
//           maxHeight: MediaQuery.of(context).size.height * 0.8,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(18.0),
//             topRight: Radius.circular(18.0),
//           ),
//           boxShadow: null,
//           parallaxEnabled: true,
//           parallaxOffset: 0.5,
//           isDraggable: true,
//           renderPanelSheet: true,
//           backdropEnabled: true,
//           backdropOpacity: 0.5,
//           backdropColor: Colors.black,
//         ),
//       ]),
//     );
//   }

//   Widget _buildPanel(ScrollController scrollController) {
//     return Container(
//       child: Center(
//         child: Text(
//           'Your content here',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

class DraggableBottomSheet extends StatefulWidget {
  @override
  _DraggableBottomSheetState createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  final PanelController _panelController1 = PanelController();
  final PanelController _panelController2 = PanelController();
  final PanelController _panelController3 = PanelController();
  bool _isPanel1Open = false;
  bool _isPanel2Open = false;
  bool _isPanel3Open = false;

  void _togglePanel1() {
    _isPanel1Open ? _panelController1.close() : _panelController1.open();
    setState(() {
      _isPanel1Open = !_isPanel1Open;
    });
  }

  void _togglePanel2() {
    _isPanel2Open ? _panelController2.close() : _panelController2.open();
    setState(() {
      _isPanel2Open = !_isPanel2Open;
    });
  }

  void _togglePanel3() {
    _isPanel3Open ? _panelController3.close() : _panelController3.open();
    setState(() {
      _isPanel3Open = !_isPanel3Open;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable Bottom Sheet'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _togglePanel1,
                  child: Text(_isPanel1Open ? 'Close Panel 1' : 'Open Panel 1'),
                ),
                ElevatedButton(
                  onPressed: _togglePanel2,
                  child: Text(_isPanel2Open ? 'Close Panel 2' : 'Open Panel 2'),
                ),
                ElevatedButton(
                  onPressed: _togglePanel3,
                  child: Text(_isPanel3Open ? 'Close Panel 3' : 'Open Panel 3'),
                ),
              ],
            ),
          ),
          SlidingUpPanel(
            controller: _panelController1,
            panelBuilder: (scrollController) =>
                _buildPanel(scrollController, 1),
            minHeight: 60,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
            boxShadow: null,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            isDraggable: true,
            renderPanelSheet: true,
            backdropEnabled: true,
            backdropOpacity: 0.5,
            backdropColor: Colors.black,
          ),
          SlidingUpPanel(
            controller: _panelController2,
            panelBuilder: (scrollController) =>
                _buildPanel(scrollController, 2),
            minHeight: 60,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
            boxShadow: null,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            isDraggable: true,
            renderPanelSheet: true,
            backdropEnabled: true,
            backdropOpacity: 0.5,
            backdropColor: Colors.black,
          ),
          SlidingUpPanel(
            controller: _panelController3,
            panelBuilder: (scrollController) =>
                _buildPanel(scrollController, 3),
            minHeight: 60,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
            boxShadow: null,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            isDraggable: true,
            renderPanelSheet: true,
            backdropEnabled: true,
            backdropOpacity: 0.5,
            backdropColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildPanel(ScrollController scrollController, int panelNumber) {
    return Container(
      child: Center(
        child: Text(
          'Content of Panel $panelNumber',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
