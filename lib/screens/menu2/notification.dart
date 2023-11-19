import 'package:flutter/material.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/components/menu/notificationTile.dart';
import 'package:orbit/constants/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Notification",
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
          children: [
            SizedBox(
              height: 20,
            ),
            NotificationTile(title: "General Notification", onPress: () {}),
            NotificationTile(title: "Sound", onPress: () {}),
            NotificationTile(title: "Special Offers", onPress: () {}),
            NotificationTile(title: "Promo and Discount", onPress: () {}),
            NotificationTile(title: "Payments", onPress: () {}),
            NotificationTile(title: "App Update", onPress: () {}),
            NotificationTile(title: "New Tips Available", onPress: () {}),
          ],
        ),
      ),
    );
  }
}
