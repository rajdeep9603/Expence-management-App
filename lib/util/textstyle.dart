import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appTextStyle({
  Color? textColor,
  double? fontSize,
  FontWeight? fontWeight,
  TextDecoration? textDecoration,
  double? height,
  double? letterSpacing,
}) {
  return GoogleFonts.poppins(
    color: textColor,
    fontSize: fontSize ?? 16,
    fontWeight: fontWeight ?? FontWeight.normal,
    decoration: textDecoration ?? TextDecoration.none,
    height: height,
    letterSpacing: letterSpacing,
  );
}