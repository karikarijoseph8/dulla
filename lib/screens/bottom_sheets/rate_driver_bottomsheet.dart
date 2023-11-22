import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RateDriverBottomSheet extends StatefulWidget {
  const RateDriverBottomSheet({
    super.key,
    required this.cancelRating,
    required this.submitRating,
  });

  final VoidCallback cancelRating;
  final VoidCallback submitRating;

  @override
  State<RateDriverBottomSheet> createState() => _RateDriverBottomSheetState();
}

class _RateDriverBottomSheetState extends State<RateDriverBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      maxHeight: 410,
      //minHeight: 410,
      minHeight: 410,
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
      panelBuilder: (controller) => RateDriverPanelWidget(
        controller: controller,
        cancelRating: widget.cancelRating,
        submitRating: widget.submitRating,
      ),
    );
  }
}

class RateDriverPanelWidget extends StatefulWidget {
  const RateDriverPanelWidget({
    super.key,
    required this.controller,
    required this.cancelRating,
    required this.submitRating,
  });

  final ScrollController controller;

  final VoidCallback cancelRating;
  final VoidCallback submitRating;

  @override
  State<RateDriverPanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<RateDriverPanelWidget> {
  int _rating = 0;

  void _updateRating(int newRating) {
    setState(() {
      _rating = newRating;
    });
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rate Driver",
                style: CustomFonts.urbanist(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
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
          DriverDetailCard(),
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
          SizedBox(
            height: 12,
          ),
          //PickUpDestinationCard(),
          Text(
            "How is your driver?",
            style: CustomFonts.urbanist(
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Please rate your driver...",
            style: CustomFonts.urbanist(
              color: AppColors.greyMessages2,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 1; i <= 5; i++)
                GestureDetector(
                  onTap: () => _updateRating(i),
                  child: SvgPicture.asset(
                    _rating >= i
                        ? "assets/svgIcons/bottom_sheet_rated.svg"
                        : "assets/svgIcons/bottom_sheet_unrated.svg.svg",
                    width: 30,
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 15,
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
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.43,
                height: 50,
                child: SubmitButton(
                  onPressed: widget.submitRating,
                  buttonText: 'Submit',
                  btnColor: AppColors.mainYellow,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.43,
                height: 50,
                child: SubmitButton(
                  onPressed: widget.cancelRating,
                  buttonText: 'Cancel',
                  btnColor: AppColors.lightYellow,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PickUpDestinationCard extends StatelessWidget {
  const PickUpDestinationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            SvgPicture.asset(
              "assets/svgIcons/booking_pickup4.svg",
              width: 45,
            ),
            // SvgPicture.asset(
            //   "assets/svgIcons/booking_destination.svg",
            //   width: 45,
            // ),
          ],
        ),
        SizedBox(
          width: 17,
        ),
        Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "National Park Grand",
                      style: CustomFonts.urbanist(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "6 Glendale St. Worcester, MA 01604",
                      style: CustomFonts.urbanist(
                        color: AppColors.greyMessages2,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                SvgPicture.asset(
                  "assets/svgIcons/confirmtrip_order_edit.svg",
                  width: 16,
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "National Park Grand",
                      style: CustomFonts.urbanist(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "6 Glendale St. Worcester, MA 01604",
                      style: CustomFonts.urbanist(
                        color: AppColors.greyMessages2,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                SvgPicture.asset(
                  "assets/svgIcons/confirmtrip_order_edit.svg",
                  width: 16,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class DriverDetailCard extends StatelessWidget {
  const DriverDetailCard({
    super.key,
  });

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
                      "Reindolf Sarpong",
                      style: CustomFonts.urbanist(
                          color: AppColors.mainBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Mercedes-Benz",
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
                "AS 8654-23",
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
