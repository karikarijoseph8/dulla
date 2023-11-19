import 'package:flutter/material.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({super.key});

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => ProgressDialog(
                  status: 'Fetching details',
                ),
              );
            },
            child: Text("Alert")),
      ),
    );
  }
}

class ProgressDialog extends StatelessWidget {
  final String status;
  ProgressDialog({required this.status});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      backgroundColor: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
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
                  "assets/images/congrats.png",
                  width: 150,
                ),
                SizedBox(
                  height: 28.0,
                ),
                Text(
                  "Congratulations!",
                  style: CustomFonts.urbanist(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Your account is ready to use. You will",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "be directed to the Home page in a",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "few seconds...",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 30,
                ),
                CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.mainYellow),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
