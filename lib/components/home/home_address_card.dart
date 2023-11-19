import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAddressCard extends StatelessWidget {
  const HomeAddressCard({
    super.key,
    required this.addressName,
    required this.onPressed,
  });

  final String addressName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(left: 16),
        padding: EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.09),
              offset: Offset(0, 3),
              blurRadius: 8,
            )
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/svgIcons/Home-address.svg",
              width: 14,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              addressName,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
