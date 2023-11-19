import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit/constants/app_colors.dart';

class TopUpButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool? fullWidth;
  final Color btnColor;
  const TopUpButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.fullWidth,
    required this.btnColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        elevation: 1,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        minimumSize: fullWidth != null
            ? fullWidth!
                ? const Size.fromHeight(40)
                : null
            : null,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            "assets/svgIcons/topup.svg",
            width: 14,
          ),
          Text(
            buttonText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.mainBlack,
            ),
          ),
        ],
      ),
    );
  }
}
