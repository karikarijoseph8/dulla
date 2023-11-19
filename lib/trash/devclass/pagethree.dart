import 'package:flutter/material.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Page Three",
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
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              "Setup Evans",
              style: CustomFonts.urbanist(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Account",
              style: CustomFonts.urbanist(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 250,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 1,
                minimumSize: Size.fromHeight(40),
                backgroundColor: Color(0xFFFFBF08),
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Go Back",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
