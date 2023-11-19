import 'package:flutter/material.dart';
import 'package:orbit/components/buttons/round_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        // title: Text(
        //   "Cancel Taxi",
        //   style: CustomFonts.urbanist(
        //     fontSize: 22,
        //     fontWeight: FontWeight.w700,
        //     color: AppColors.mainBlack,
        //   ),
        // ),
        elevation: 0,
      ),
      backgroundColor: AppColors.mainWhite,
      body: Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              width: 317,
              height: 362,

              // alignment: Alignment.center,
              padding:
                  EdgeInsets.only(left: 30, top: 20, bottom: 10, right: 20),
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                //color: Colors.amber,
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/callscreen_image_background.png",
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 36,
                      ),
                      CircleAvatar(
                        radius:
                            86, // Adjust this value to change the size of the circular profile picture
                        backgroundImage: AssetImage(
                          'assets/images/babe.jpg',
                        ), // Replace this with your image asset path
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 56,
            ),
            Text(
              "Daniel Austin",
              style: CustomFonts.urbanist(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Text(
              "01:25 minutes",
              style: CustomFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.greyMessages2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 62,
                  child: RoundButton(
                    onPressed: () {
                      // Navigator.pushNamed(
                      //     context, '/homeTripCancellationScreen');
                    },
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
                    onPressed: () {
                      //Navigator.pushNamed(context, '/homeCallScreen');
                    },
                    buttonIcon: 'assets/svgIcons/call_screen_loud_speaker.svg',
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
