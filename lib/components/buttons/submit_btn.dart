import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool? fullWidth;
  final Color btnColor;
  final bool isDisabled;

  const SubmitButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.fullWidth,
    required this.btnColor,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled
            ? btnColor.withOpacity(0.5)
            : btnColor,
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
      onPressed:  isDisabled ? null : onPressed,
      child: Text(
        buttonText,
        style: CustomFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.mainBlack,
        ),
      ),
    );
  }
}

class SubmitButton2 extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool? fullWidth;
  final Color btnColor;
  final Widget child;
  const SubmitButton2({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.fullWidth,
    required this.btnColor,
    required this.child,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
          SizedBox(
            width: 10,
          ),
          Text(
            buttonText,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.mainBlack,
            ),
          ),
        ],
      ),
    );
  }
}
