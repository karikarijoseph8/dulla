import 'package:flutter/material.dart';
import 'package:orbit/components/buttons/submit_btn.dart';
import 'package:orbit/components/customfont/customfonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/screens/dialogs/topup_dialog.dart';

class DialogTemp extends StatefulWidget {
  const DialogTemp({super.key});

  @override
  State<DialogTemp> createState() => _DialogTempState();
}

class _DialogTempState extends State<DialogTemp> {
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
          "Dialog Temp",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: SubmitButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => TopUpDialog(
                      status: 'Fetching details',
                    ),
                  );
                },
                buttonText: 'Show Dialog',
                btnColor: AppColors.mainYellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
