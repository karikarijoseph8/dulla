import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orbit/components/customfont/customfonts.dart';
import 'package:orbit/constants/app_colors.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final FormFieldValidator<String> validator;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final bool? enabled;
  final FocusNode? focusNode;
  final TextStyle? style;
  final Widget? prefix;
  final String? prefixText;
  final Widget? preffixIcon;
  final Widget? suffixIcon;
  const AuthTextFormField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.validator,
    this.obscureText,
    this.keyboardType,
    this.textCapitalization,
    this.enabled,
    this.prefix,
    this.prefixText,
    this.preffixIcon,
    this.suffixIcon,
    this.style,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      style: style,
      obscureText: obscureText ?? false,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: Color(0xFF212121),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFFAFAFA),
        hintText: hint,
        hintStyle: CustomFonts.urbanist(color: Color(0xFF9E9E9E), fontSize: 16),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
        // prefixText: prefixText,
        //prefixStyle: CustomFonts.urbanist(fontSize: 16),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefix: prefix,
        prefixIcon: preffixIcon,
        prefixIconColor: Colors.amber,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColors.mainYellow, width: 1.0),
        ),
      ),
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      enabled: enabled,
    );
  }
}

class PhoneAuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextStyle? style;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final bool? enabled;
  final Widget? prefix;
  final String? prefixText;
  final Widget? preffixIcon;
  final Widget? suffixIcon;
  const PhoneAuthTextFormField({
    Key? key,
    required this.controller,
    required this.hint,
    this.style,
    this.obscureText,
    this.keyboardType,
    this.textCapitalization,
    this.enabled,
    this.prefix,
    this.prefixText,
    this.preffixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      obscureText: obscureText ?? false,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: Color(0xFF212121),
      //maxLength: 15,
      style: style,
      decoration: InputDecoration(
        //filled: true,
        // fillColor: Color(0xFFFAFAFA),
        hintText: hint,
        hintStyle: CustomFonts.urbanist(color: Color(0xFF9E9E9E), fontSize: 16),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
        // prefixText: prefixText,
        //prefixStyle: CustomFonts.urbanist(fontSize: 16),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefix: prefix,
        prefixIcon: preffixIcon,
        prefixIconColor: Colors.amber,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        //   borderSide: BorderSide(color: AppColors.mainYellow, width: 1.0),
        // ),
      ),

      inputFormatters: [PhoneFormatter()],
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      enabled: enabled,
    );
  }
}

class PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text =
        newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
    final formattedText = _formatPhoneNumber(text); // Format as desired
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatPhoneNumber(String text) {
    if (text.length <= 3) {
      return text;
    } else if (text.length <= 6) {
      return '${text.substring(0, 3)} ${text.substring(3)}';
    } else if (text.length <= 10) {
      return '${text.substring(0, 3)} ${text.substring(3, 6)} ${text.substring(6)}';
    } else {
      return '${text.substring(0, 3)} ${text.substring(3, 6)} ${text.substring(6, 10)}';
    }
  }
}
