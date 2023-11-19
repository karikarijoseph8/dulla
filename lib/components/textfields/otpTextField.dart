import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbit/components/app_scale.dart';

import '../../constants/app_colors.dart';

class otpTextField extends StatefulWidget {
  otpTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<otpTextField> createState() => _otpTextFieldState();
}

class _otpTextFieldState extends State<otpTextField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppScale appScale = AppScale(context);
    return SizedBox(
      height: appScale.scaleHeight(8.72), //68
      //width: 64,
      //width: appScale.scaleWidth(5.642), //44
      width: 300, //44
      child: TextFormField(
        controller: widget.controller,
        obscureText: true,
        onChanged: (value) {
          // if (value.length == 6) {
          //   FocusScope.of(context).nextFocus();
          // } else if (value.isEmpty && widget.fieldNumber > 6) {
          //   FocusScope.of(context).previousFocus();
          // }
        },
        style: GoogleFonts.poppins(
          color: AppColors.mainBlack,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.all(8.0),
          filled: true,
          fillColor: Color(0xFFFAFAFA),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: AppColors.mainYellow, width: 1.0),
          ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }

  int _focusedField = 0;
}
