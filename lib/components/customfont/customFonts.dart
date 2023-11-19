import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFonts {
  static const String _fontName =
      "Urbanist"; // Replace with your desired font name

  static TextStyle urbanist({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    //double? letterSpacing,
    // double? wordSpacing,
    //TextBaseline? textBaseline,
    //double? height,
    // Locale? locale,
    //Paint? foreground,
    //Paint? background,
    //List<Shadow>? shadows,
    // TextDecoration? decoration,
    // Color? decorationColor,
    // TextDecorationStyle? decorationStyle,
    // double? decorationThickness,
    // String? debugLabel,
  }) {
    return GoogleFonts.urbanist(
      fontWeight: fontWeight ?? FontWeight.w400,
      fontSize: fontSize ?? 14,
      color: color ?? Colors.black,
      // letterSpacing: letterSpacing,
      // wordSpacing: wordSpacing,
      // textBaseline: textBaseline,
      // height: height,
      // locale: locale,
      // foreground: foreground,
      // background: background,
      // shadows: shadows,
      // decoration: decoration,
      // decorationColor: decorationColor,
      // decorationStyle: decorationStyle,
      // decorationThickness: decorationThickness,
      // debugLabel: debugLabel,
    );
  }

  static TextStyle poppins({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    //double? letterSpacing,
    // double? wordSpacing,
    //TextBaseline? textBaseline,
    //double? height,
    // Locale? locale,
    //Paint? foreground,
    //Paint? background,
    //List<Shadow>? shadows,
    // TextDecoration? decoration,
    // Color? decorationColor,
    // TextDecorationStyle? decorationStyle,
    // double? decorationThickness,
    // String? debugLabel,
  }) {
    return GoogleFonts.poppins(
      fontWeight: fontWeight ?? FontWeight.w400,
      fontSize: fontSize ?? 14,
      color: color ?? Colors.black,
      // letterSpacing: letterSpacing,
      // wordSpacing: wordSpacing,
      // textBaseline: textBaseline,
      // height: height,
      // locale: locale,
      // foreground: foreground,
      // background: background,
      // shadows: shadows,
      // decoration: decoration,
      // decorationColor: decorationColor,
      // decorationStyle: decorationStyle,
      // decorationThickness: decorationThickness,
      // debugLabel: debugLabel,
    );
  }
}
