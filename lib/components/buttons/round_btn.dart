import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit/constants/app_colors.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonIcon;
  final double buttonIconSize;
  final bool? fullWidth;
  final Color btnColor;
  const RoundButton({
    Key? key,
    required this.onPressed,
    required this.buttonIcon,
    this.fullWidth,
    required this.btnColor,
    required this.buttonIconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        elevation: 1,
        shadowColor: Colors.transparent,
        shape: CircleBorder(),
        minimumSize: fullWidth != null
            ? fullWidth!
                ? const Size.fromHeight(40)
                : null
            : null,
      ),
      onPressed: onPressed,
      child: SvgPicture.asset(
        buttonIcon,
        width: buttonIconSize,
      ),
    );
  }
}
