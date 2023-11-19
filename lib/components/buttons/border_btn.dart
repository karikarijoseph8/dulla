import 'package:flutter/material.dart';
import 'package:orbit/constants/app_colors.dart';

class BorderButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool? fullWidth;
  final Color btnColor;
  const BorderButton({
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
        // backgroundColor: btnColor,
        elevation: 1,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(width: 2.0, color: Colors.blue),
        ),
        minimumSize: fullWidth != null
            ? fullWidth!
                ? const Size.fromHeight(40)
                : null
            : null,
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.mainBlack,
        ),
      ),
    );
  }
}
