import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit/components/customfont/customfonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/screens/menu2/help_center/contact_us_page.dart';
import 'package:orbit/screens/menu2/help_center/faq_page.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.mainBlack, // Change this to your desired color
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Help Center",
            style: CustomFonts.urbanist(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.mainBlack,
            ),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            TabBar(
              isScrollable: true,
              labelColor: AppColors.mainYellow,
              unselectedLabelColor: AppColors.greyBalck,
              indicatorColor: AppColors.mainYellow,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: CustomFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              tabs: [
                Tab(
                  text: "FAQ",
                ),
                Tab(
                  text: "Contact Us",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                FAQ(),
                ContactUs(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
