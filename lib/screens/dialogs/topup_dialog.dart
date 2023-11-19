import 'package:flutter/material.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

class TopUpDialog extends StatelessWidget {
  final String status;
  TopUpDialog({required this.status});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
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
                "assets/images/dialog_wallet_topup.png",
                width: 158,
              ),
              SizedBox(
                height: 28.0,
              ),
              Column(
                children: [
                  Text(
                    //  "Top Up Sucessful!",
                    "Payment Sucessful!",
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
                "Payment of GHS20 has been",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                "successfully processed",
                style: TextStyle(fontSize: 14),
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
