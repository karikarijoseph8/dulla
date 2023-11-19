import 'package:flutter/material.dart';

class AuthSocialButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final bool? fullWidth;
  const AuthSocialButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.fullWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 27,
            vertical: 15.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
      child: child,
    );
  }
}
