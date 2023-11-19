import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leftIconPath,
    required this.onPress,
  });

  final String title;
  final String subTitle;
  final String leftIconPath;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Material(
        child: InkWell(
          onTap: onPress,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      leftIconPath,
                      width: 16,
                      color: Color(0xFF777A85),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          subTitle,
                          style: GoogleFonts.poppins(
                            color: Color(0xFF757983),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
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
      ),
    );
  }
}
