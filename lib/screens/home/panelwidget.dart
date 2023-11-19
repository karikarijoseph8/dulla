import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

class PanelWidget extends StatelessWidget {
  const PanelWidget(
      {super.key, required this.controller, required this.onPressed});

  final ScrollController controller;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Padding(padding: EdgeInsets.zero);
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          // Container(
          //   height: 6,
          //   width: 46,
          //   decoration: BoxDecoration(
          //     color: Color(0xFFF4F4F6),
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          // ),
          SizedBox(
            height: 25,
          ),

          GestureDetector(
            onTap: onPressed,
            // onTap: () async {
            //   var response = await Navigator.push(
            //     context,
            //     PageTransition(
            //         type: PageTransitionType.bottomToTop,
            //         child: SearchLocationPage(),
            //         // childCurrent: this,
            //         duration: Duration(milliseconds: 300)),
            //   );

            //   if (response == 'getDirection') {
            //     print("GETTING DIRECTION");
            //     //showDetailSheet();
            //   }
            // },
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 9,
                bottom: 9,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: Color(0xFFF3F3FA),
                color: Color(0xFFFAFAFA),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Where are you going?",
                    style: CustomFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/svgIcons/arrow-right.svg",
                    width: 30,
                    color: AppColors.mainBlack,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
