import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:truncate/truncate.dart';
import '../../models/trip/address.dart';
import '../../service/providers/trip/route_provider.dart';

class ConfirmOrderBottomSheet extends StatelessWidget {
  const ConfirmOrderBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      maxHeight: 300,
      minHeight: 300,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(18.0),
        topLeft: Radius.circular(18.0),
      ),
      parallaxEnabled: true,
      parallaxOffset: .5,
      panelSnapping: true,
      backdropEnabled: true,
      boxShadow: const [
        BoxShadow(
          spreadRadius: 6,
          blurRadius: 4.0,
          color: Color.fromRGBO(0, 0, 0, 0.05),
        )
      ],
      body: Container(),
      panelBuilder: (controller) => ConfirmPanelWidget(),
    );
  }
}

class ConfirmPanelWidget extends StatelessWidget {
  const ConfirmPanelWidget({
    super.key,
  });

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
              Text(
                "Distance",
                style: CustomFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "23.3 km",
                style: CustomFonts.poppins(
                  //fontSize: 20,
                  //fontWeight: FontWeight.w500,
                  //color: AppColors.greyMessages2,
                  color: Color(0xFF666563),
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
          SizedBox(
            height: 12,
          ),
          PickUpDestinationCard(),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            child: SubmitButton(
              onPressed: () {},
              buttonText: 'Continue to Order',
              btnColor: AppColors.mainYellow,
            ),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 14,
            ),
            Container(
              width: 18, // Adjust the width as needed
              height: 18, // Adjust the height as needed
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Makes it a circular container
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFCC3B), Color(0xFFF8B71C)],
                ),
              ),
              child: Center(
                child: Container(
                  width: 8, // Adjust the width of the centered white container
                  height:
                      8, // Adjust the height of the centered white container
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle, // Makes it a circular container
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 18, // Adjust the width as needed
              height: 18, // Adjust the height as needed
              decoration: BoxDecoration(
                  shape: BoxShape.circle, // Makes it a circular container
                  color: Color(0xFFBAB9B7)),
              child: Center(
                child: Container(
                  width: 8, // Adjust the width of the centered white container
                  height:
                      8, // Adjust the height of the centered white container
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle, // Makes it a circular container
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConfirmOrderTile(),
              SizedBox(
                height: 20,
              ),
              ConfirmOrderTile(),
            ],
          ),
        ),
      ],
    );
  }
}

class ConfirmOrderTile extends StatelessWidget {
  const ConfirmOrderTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ranchview",
                  style: CustomFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  //truncate(address.placeFormattedAddress, 40, omission: "..."),
                  "1901 Thornridge Cir. Shiloh",
                  style: CustomFonts.poppins(
                    //color: AppColors.greyMessages2,
                    //color: Color(0xFF636773),666563
                    color: Color(0xFF666563),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            // SvgPicture.asset(
            //   "assets/svgIcons/confirmtrip_order_edit.svg",
            //   width: 16,
            // )
          ],
        ),
      ),
    );
  }

  String getFirstPartBeforeComma(String input) {
    // Split the input string by the comma
    List<String> parts = input.split(',');

    // Check if there is at least one part before the comma
    if (parts.isNotEmpty) {
      // Return the first part (trimmed to remove leading/trailing spaces)
      return parts.first.trim();
    } else {
      // Return an empty string if there are no parts before the comma
      return '';
    }
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
                      "Divas Elk",
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
