import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:orbit/components/app_alerts_dialogs.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/components/textfields/authTextField.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/service/realtime_db_service.dart';

class TripCancellationScreen extends StatefulWidget {
  const TripCancellationScreen({super.key, required this.rideID});
  final rideID;
  @override
  State<TripCancellationScreen> createState() => _TripCancellationScreenState();
}

class _TripCancellationScreenState extends State<TripCancellationScreen> {
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;
  bool _isSelected4 = false;
  bool _isSelected5 = false;
  bool _isSelected6 = false;
  bool _isSelected7 = false;
  final formKey = GlobalKey<FormState>();
  late DatabaseReference rideRef;

  final TextEditingController other_reasonContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final RealtimeDBService realtimeDBService = RealtimeDBService();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Cancel Ride",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: AppColors.mainWhite,
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.mainYellow,
                      value: _isSelected1,
                      onChanged: (value) {
                        setState(() {
                          _isSelected1 = value!;
                        });
                      },
                    ),
                    Text(
                      'Waiting for long time',
                      style: CustomFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.mainYellow,
                      value: _isSelected2,
                      onChanged: (value) {
                        setState(() {
                          _isSelected2 = value!;
                        });
                      },
                    ),
                    Text(
                      'Unable to connect driver',
                      style: CustomFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.mainYellow,
                      value: _isSelected3,
                      onChanged: (value) {
                        setState(() {
                          _isSelected3 = value!;
                        });
                      },
                    ),
                    Text(
                      'Driver denied to go to destination ',
                      style: CustomFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.mainYellow,
                      value: _isSelected4,
                      onChanged: (value) {
                        setState(() {
                          _isSelected4 = value!;
                        });
                      },
                    ),
                    Text(
                      'Driver denied to come to pickup',
                      style: CustomFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.mainYellow,
                      value: _isSelected5,
                      onChanged: (value) {
                        setState(() {
                          _isSelected5 = value!;
                        });
                      },
                    ),
                    Text(
                      'Wrong address shown',
                      style: CustomFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.mainYellow,
                      value: _isSelected6,
                      onChanged: (value) {
                        setState(() {
                          _isSelected6 = value!;
                        });
                      },
                    ),
                    Text(
                      'The price is not reasonable',
                      style: CustomFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.mainYellow,
                      value: _isSelected7,
                      onChanged: (value) {
                        setState(() {
                          _isSelected7 = value!;
                        });
                      },
                    ),
                    Text(
                      'The price is not reasonable',
                      style: CustomFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Others",
                    style: CustomFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: AuthTextFormField(
                            controller: other_reasonContoller,
                            hint: 'Other reasons',
                            validator: (val) => val!.length > 30
                                ? 'More than 30 characters'
                                : val.length < 2
                                    ? 'Too short'
                                    : null,
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: SubmitButton(
                      onPressed: () {
                        showLoadingDialog(context);

                        realtimeDBService
                            .terminatedRide(widget.rideID)
                            .then((value) {
                          Navigator.pop(context);
                        });
                        Navigator.pop(context);
                        // showDialog(
                        //   barrierDismissible: false,
                        //   context: context,
                        //   builder: (BuildContext context) => ProgressDialog(
                        //     status: 'Fetching details',
                        //   ),
                        // );
                      },
                      buttonText: 'Continue',
                      btnColor: AppColors.mainYellow,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
