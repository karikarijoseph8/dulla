import 'package:flutter/material.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/components/menu/notificationTile.dart';
import 'package:orbit/constants/app_colors.dart';

class MenuTemp2 extends StatefulWidget {
  const MenuTemp2({super.key});

  @override
  State<MenuTemp2> createState() => _MenuTemp2State();
}

class _MenuTemp2State extends State<MenuTemp2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Menu Temp Two",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
