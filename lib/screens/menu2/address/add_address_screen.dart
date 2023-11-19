import 'package:flutter/material.dart';
import 'package:orbit/constants/app_colors.dart';

import '../../../components/customfont/customFonts.dart';

class AddNewAddress extends StatelessWidget {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          "Add New Address",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Text("data"),
    );
  }
}
