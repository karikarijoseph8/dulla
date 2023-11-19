import 'package:flutter/material.dart';
import 'package:orbit/screens/bottom_sheets/confirm_order_bottomsheet.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../screens/bottom_sheets/rate_driver_bottomsheet.dart';

class SheetTest extends StatefulWidget {
  const SheetTest({super.key});

  @override
  State<SheetTest> createState() => _SheetTestState();
}

class _SheetTestState extends State<SheetTest> {
  PanelController confirmOrderPanelController = PanelController();
  PanelController driverArrivingPanelController = PanelController();

  double confirmOrder = 300;
  double driverArriving = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        CustomSlidingPanel(
          body: Center(
            child: Text('Main Content Goes Here'),
          ),
          panel: Center(
            child: Text('Sliding Panel Content Goes Here'),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AnimatedSize(
              duration: new Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              child: Container(
                height: confirmOrder,
                //padding: EdgeInsets.only(left: 20, right: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 3),
                        blurRadius: 8,
                      )
                    ]),
                child: ConfirmOrderBottomSheet(
                  destinationOnPress: () {},
                  pickupOnPress: () {},
                  submitBtn: () {},
                ),
              )),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AnimatedSize(
              duration: new Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              child: Container(
                height: driverArriving,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 3),
                        blurRadius: 8,
                      )
                    ]),
                child: RateDriverBottomSheet(
                  cancelRating: () {
                    setState(() {
                      confirmOrderPanelController.show();
                      driverArrivingPanelController.close();
                      confirmOrder == 300;
                      driverArriving = 0;
                    });
                  },
                  submitRating: () {},
                  // driverArrivingPanelController: driverArrivingPanelController,
                ),
              )),
        ),
      ]),
    );
  }
}

class CustomSlidingPanel extends StatefulWidget {
  final Widget panel;
  final Widget body;

  CustomSlidingPanel({required this.panel, required this.body});

  @override
  _CustomSlidingPanelState createState() => _CustomSlidingPanelState();
}

class _CustomSlidingPanelState extends State<CustomSlidingPanel> {
  double panelPosition = 0.0;
  double panelMinHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.body,
        Positioned(
          bottom: panelPosition,
          left: 0,
          right: 0,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                panelPosition = details.localPosition.dy;
              });
            },
            onVerticalDragEnd: (details) {
              if (panelPosition < panelMinHeight / 2) {
                setState(() {
                  panelPosition = 0.0;
                });
              } else {
                setState(() {
                  panelPosition = panelMinHeight;
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (panelPosition == 0.0) {
                          panelPosition = panelMinHeight;
                        } else {
                          panelPosition = 0.0;
                        }
                      });
                    },
                    child: Container(
                      width: 40.0,
                      height: 5.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                  ),
                  widget.panel,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
