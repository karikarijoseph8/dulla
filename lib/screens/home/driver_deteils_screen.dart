import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit/components/buttons/round_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

class DriverDetailsScreen extends StatefulWidget {
  const DriverDetailsScreen({super.key});

  @override
  State<DriverDetailsScreen> createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Driver Details",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius:
                  52, // Adjust this value to change the size of the circular profile picture
              backgroundImage: AssetImage(
                  'assets/images/babe.jpg'), // Replace this with your image asset path
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              "Reindolf Sarpong",
              style: CustomFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "+233-597-537-1771",
                  style: CustomFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.copy_sharp,
                  color: AppColors.mainYellow,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RatingTrips(),
            SizedBox(
              height: 20,
            ),
            MembershipCarDetail(),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 62,
                  child: RoundButton(
                    onPressed: () {},
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/homeCallScreen');
                    },
                    buttonIcon: 'assets/svgIcons/bottom_sheet_call.svg',
                    btnColor: AppColors.mainYellow,
                    buttonIconSize: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RatingTrips extends StatelessWidget {
  const RatingTrips({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                //width: 100,
                // height: 100,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors
                      .mainYellow, // Set the background color of the circle
                ),
                child: SvgPicture.asset(
                  "assets/svgIcons/rating.svg",
                  width: 18,
                  color: AppColors.mainBlack,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "4.8",
                style: CustomFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainBlack),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "Rating",
                style: CustomFonts.urbanist(
                  color: AppColors.greyMessages2,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors
                      .mainYellow, // Set the background color of the circle
                ),
                child: SvgPicture.asset(
                  "assets/svgIcons/car_taxi.svg",
                  width: 18,
                  color: AppColors.mainBlack,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "279",
                style: CustomFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainBlack),
              ),
              Text(
                "Trips",
                style: CustomFonts.urbanist(
                  color: AppColors.greyMessages2,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                //width: 100,
                // height: 100,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors
                      .mainYellow, // Set the background color of the circle
                ),
                child: SvgPicture.asset(
                  "assets/svgIcons/booking_duration.svg",
                  width: 18,
                  color: AppColors.mainBlack,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "2",
                style: CustomFonts.urbanist(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainBlack,
                ),
              ),
              Text(
                "Years",
                style: CustomFonts.urbanist(
                  color: AppColors.greyMessages2,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MembershipCarDetail extends StatelessWidget {
  const MembershipCarDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Member Since",
                  style: CustomFonts.urbanist(
                    color: AppColors.greyMessages2,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "July 20, 2023",
                  style: CustomFonts.urbanist(
                      color: AppColors.mainBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Car Model",
                style: CustomFonts.urbanist(
                  color: AppColors.greyMessages2,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Mercedes-Benz",
                style: CustomFonts.urbanist(
                  color: AppColors.mainBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Plate Number",
                style: CustomFonts.urbanist(
                  color: AppColors.greyMessages2,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    "AS 4736 23",
                    style: CustomFonts.urbanist(
                      color: AppColors.mainBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
