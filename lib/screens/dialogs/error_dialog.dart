import 'package:flutter/material.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String body;
  ErrorDialog({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.only(left: 15, right: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: EdgeInsets.only(
            top: 34,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/error_dialog_emoji.png",
                width: 138,
              ),
              SizedBox(
                height: 28.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
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
                body,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 1,
              ),
              SizedBox(
                height: 22,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50,
                child: SubmitButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  buttonText: 'OK',
                  btnColor: AppColors.mainYellow,
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
