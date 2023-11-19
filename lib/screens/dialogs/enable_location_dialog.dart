import 'package:flutter/material.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

class EnableLocationDialog extends StatelessWidget {
  // final String status;
  // EnableLocationDialog({required this.status});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: EdgeInsets.only(
            top: 34,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/dialog_enable_location.png",
                width: 138,
              ),
              SizedBox(
                height: 28.0,
              ),
              Column(
                children: [
                  Text(
                    "Enable Location",
                    style: CustomFonts.urbanist(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14.0,
              ),
              Text(
                "We need access to your location to be",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                "able to use this service",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50,
                child: SubmitButton(
                  onPressed: () {
                    //Navigator.of(context).pop();
                  },
                  buttonText: 'OK',
                  btnColor: AppColors.mainYellow,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50,
                child: SubmitButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  buttonText: 'NOT NOW',
                  btnColor: AppColors.lightYellow,
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
