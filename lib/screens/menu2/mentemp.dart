import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit/components/customfont/customfonts.dart';
import 'package:orbit/constants/app_colors.dart';

class MenuTemp extends StatefulWidget {
  const MenuTemp({super.key});

  @override
  State<MenuTemp> createState() => _MenuTempState();
}

class _MenuTempState extends State<MenuTemp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(
              color: AppColors.mainBlack, // Change this to your desired color
            ),
            backgroundColor: Colors.white,
            title: Text(
              "Profile",
              style: CustomFonts.urbanist(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.mainBlack,
              ),
            ),
            elevation: 0,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              //Todo goes here
            ]),
          )
        ],
      ),
    );
  }
}

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    super.key,
    required this.title,
    required this.leftIconPath,
    required this.leftIconSize,
    required this.onPress,
    required this.leftIconColor,
  });

  final String title;
  final String leftIconPath;
  final Color leftIconColor;
  final double leftIconSize;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPress,
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    leftIconPath,
                    width: leftIconSize,
                    color: leftIconColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: CustomFonts.urbanist(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: leftIconColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Color(0xFFB7B9BA),
              )
            ],
          ),
        ),
      ),
    );
  }
}
