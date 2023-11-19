import 'package:flutter/material.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customfonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/screens/bottom_sheets/order_bottomsheet.dart';
import 'package:orbit/screens/bottom_sheets/rate_driver_bottomsheet.dart';
import 'package:orbit/screens/bottom_sheets/select_car2.dart';
import 'package:orbit/screens/bottom_sheets/select_ride_bottom_sheet.dart';
import 'package:orbit/screens/bottom_sheets/tip_for_driver_bottomsheet.dart';
import 'package:orbit/screens/bottom_sheets/tripto_destination_bottomsheet.dart';
import 'package:orbit/screens/bottom_sheets/your_mood_bottomsheet.dart';
import 'package:orbit/screens/dialogs/arrival_dialog.dart';
import 'package:orbit/screens/dialogs/cancellation_dialog.dart';
import 'package:orbit/screens/dialogs/enable_location_dialog.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../screens/bottom_sheets/confirm_order_bottomsheet.dart';
import '../screens/bottom_sheets/driver_arriving_bottomsheet.dart';
import '../screens/bottom_sheets/searching_for_driver.dart';

class BottomSheetTemp extends StatefulWidget {
  const BottomSheetTemp({super.key});

  @override
  State<BottomSheetTemp> createState() => _BottomSheetTempState();
}

class _BottomSheetTempState extends State<BottomSheetTemp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Driver Rating",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  child: SubmitButton(
                    onPressed: () {},
                    buttonText: 'Show Bottom Sheet',
                    btnColor: AppColors.mainYellow,
                  ),
                ),
              ],
            ),
          ),

          SearchingForDriver(
            cancelDriverSearch: () {},
          )
          //OrderBottomSheet(),
          //OrderBottomSheet()
          //SelectCarBottomSheet()
          //DriverArrivingBottomSheet(),
          //SearchingForDriver(),
          //RateDriverBottomSheet()
        ],
      ),
    );
  }
}
