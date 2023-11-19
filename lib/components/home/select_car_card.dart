import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/models/trip/car_category_entity.dart';

class SelectCarCard extends StatelessWidget {
  const SelectCarCard({
    super.key,
    required this.carCat,
    required this.isSelected,
    required this.onTap,
    required this.tripFare,
  });
  final CarCategoryEntity carCat;
  final bool isSelected;
  final double tripFare;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 16),
        padding: EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFFFCF2) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          border: isSelected
              ? Border.all(
                  color: AppColors.mainYellow, // Border color
                  width: 1.0, // Border width
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icons/yellow_car_export.png",
              width: 50,
            ),
            Text(
              carCat.categoryName,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF636773),
              ),
            ),
            Text(
              "GHS ${tripFare.round()}",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
