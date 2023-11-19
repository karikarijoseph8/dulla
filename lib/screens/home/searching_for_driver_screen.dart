import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/models/entities/trip_request.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import '../../service/providers/trip/route_provider.dart';

class SearchingForDriverScreen extends StatefulWidget {
  const SearchingForDriverScreen({
    super.key,
  });
  //final TripRequestEntity tripRequestEntity;

  @override
  State<SearchingForDriverScreen> createState() =>
      _SearchingForDriverScreenState();
}

class _SearchingForDriverScreenState extends State<SearchingForDriverScreen> {
  bool _isVisible = true;
  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _isVisible = !_isVisible;
      });
    });
    super.initState();

    final routeDataProvider =
        Provider.of<RouteDataProvider>(context, listen: false);

    final string = routeDataProvider.getRideAccepted;

    if (string == "accepted") {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Searching for Driver",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      // backgroundColor: Colors.blue,
      body: Container(
        //margin: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            image: const DecorationImage(
          image: AssetImage(
            "assets/images/searching_for_driver_bg.png",
          ),
          fit: BoxFit.fitWidth,
        )),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text("data"),

            SizedBox(
              height: 20,
            ),

            Image.asset(
              "assets/images/searching_for_driver_car.png",
              width: 40,
            ),

            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Searching Ride",
                  style: CustomFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainBlack,
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
                      color: AppColors.mainBlack,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "This may take a few seconds",
              style: CustomFonts.urbanist(
                color: AppColors.greyMessages2,
                fontSize: 16,
              ),
            ),

            SizedBox(
              height: 450,
            ),

            //SlideActionAnimation(),
            ConfirmationSlider(
              shadow: BoxShadow(color: AppColors.mainYellow),
              backgroundColor: AppColors.mainYellow,
              foregroundColor: AppColors.lightYellow,
              iconColor: AppColors.mainBlack,
              height: 60,
              width: 250,
              onConfirmation: () {
                Navigator.pushNamed(context, '/homeTripCancellationScreen');
              },
              sliderButtonContent: Icon(Icons.close),
              text: ">>Slide to Cancel",
              textStyle: CustomFonts.urbanist(
                fontSize: 16,
                color: AppColors.mainBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
