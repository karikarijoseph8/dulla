import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbit/components/buttons/round_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/components/shimmer/shimmer.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/models/entities/driver_entity.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DriverArrivingBottomSheet extends StatelessWidget {
  const DriverArrivingBottomSheet({
    super.key,
    required this.driverEntity,
    required this.showChatOnPressed,
    required this.openCallOnPressed,
    required this.cancelTripOnPressed,
  });

  final DriverEntity driverEntity;

  final VoidCallback showChatOnPressed;
  final VoidCallback openCallOnPressed;
  final VoidCallback cancelTripOnPressed;
  @override
  Widget build(BuildContext context) {
    print("Driver is here: ${driverEntity.driverName}");
    return SlidingUpPanel(
      maxHeight: 300,
      minHeight: 240,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(18.0),
        topLeft: Radius.circular(18.0),
      ),
      parallaxEnabled: true,
      parallaxOffset: .5,
      panelSnapping: true,
      backdropEnabled: false,
      boxShadow: const [
        BoxShadow(
          spreadRadius: 6,
          blurRadius: 4.0,
          color: Color.fromRGBO(0, 0, 0, 0.05),
        )
      ],
      body: Container(),
      panelBuilder: (controller) => DriverArrivingBottomSheetPanelWidget(
        controller: controller,
        driverEntity: driverEntity,
        showChatOnPressed: showChatOnPressed,
        openCallOnPressed: openCallOnPressed,
        cancelTripOnPressed: cancelTripOnPressed,
      ),
    );
  }
}

class DriverArrivingBottomSheetPanelWidget extends StatefulWidget {
  const DriverArrivingBottomSheetPanelWidget({
    super.key,
    required this.controller,
    required this.driverEntity,
    required this.showChatOnPressed,
    required this.openCallOnPressed,
    required this.cancelTripOnPressed,
  });

  final ScrollController controller;
  final VoidCallback showChatOnPressed;
  final VoidCallback openCallOnPressed;
  final VoidCallback cancelTripOnPressed;
  final DriverEntity driverEntity;

  @override
  State<DriverArrivingBottomSheetPanelWidget> createState() =>
      _DriverArrivingBottomSheetPanelWidgetState();
}

class _DriverArrivingBottomSheetPanelWidgetState
    extends State<DriverArrivingBottomSheetPanelWidget> {
  bool _isVisible = true;
  @override
  void initState() {
    // Timer.periodic(Duration(milliseconds: 500), (timer) {
    //   setState(() {
    //     _isVisible = !_isVisible;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Padding(padding: EdgeInsets.zero);
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Driver is Arriving",
                    style: CustomFonts.urbanist(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _isVisible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: Text(
                      '...',
                      style: CustomFonts.urbanist(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "2 mins",
                style: CustomFonts.urbanist(
                  //fontSize: 20,
                  //fontWeight: FontWeight.w500,
                  color: AppColors.greyMessages2,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Divider(
                  thickness: 1, // Set the thickness of the divider
                  color: Color(0xFFEEEEEE), //Set the color of the divider
                ),
              ),
            ],
          ),
          if (widget.driverEntity.driverName == '') ...[
            const Row(
              children: [
                CircleShimmer(
                  size: 58,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Shimmer(
                      width: 240,
                      height: 15,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Shimmer(
                      width: 240,
                      height: 15,
                    )
                  ],
                )
              ],
            )
          ] else ...[
            DriverDetailCard(
              driverEntity: widget.driverEntity,
            )
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 62,
                child: RoundButton(
                  onPressed: widget.cancelTripOnPressed,
                  buttonIcon: 'assets/svgIcons/bottom_sheet_close.svg',
                  btnColor: AppColors.lightYellow,
                  buttonIconSize: 15,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 62,
                child: RoundButton(
                  onPressed: widget.showChatOnPressed,
                  buttonIcon: 'assets/svgIcons/bottom_sheet_chat.svg',
                  btnColor: AppColors.mainYellow,
                  buttonIconSize: 22,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 62,
                child: RoundButton(
                  onPressed: widget.showChatOnPressed,
                  buttonIcon: 'assets/svgIcons/bottom_sheet_call.svg',
                  btnColor: AppColors.mainYellow,
                  buttonIconSize: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DriverDetailCard extends StatelessWidget {
  const DriverDetailCard({
    super.key,
    required this.driverEntity,
  });

  final DriverEntity driverEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.only(
        top: 14,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius:
                    26, // Adjust this value to change the size of the circular profile picture
                backgroundImage: AssetImage(
                    'assets/images/babe.jpg'), // Replace this with your image asset path
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driverEntity.driverName,
                      style: CustomFonts.urbanist(
                          color: AppColors.mainBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                        "${driverEntity.vehicleModel} ${driverEntity.vehicleColor}",
                        style: CustomFonts.urbanist(
                            color: AppColors.greyMessages2, fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svgIcons/rating.svg",
                    width: 16,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "4.8",
                    style: CustomFonts.urbanist(
                      color: AppColors.greyMessages2,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                driverEntity.licenseNumber,
                style: CustomFonts.urbanist(
                  color: AppColors.mainBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
