import 'package:flutter/material.dart';

class ColorRes{

  static const Color textHintColor = Color(0xFFAAACAE);
  static const Color background = Color(0xFFEEEFF1);
  static const Color filledText = Color(0xFF3D3D3D);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Colors.red;
  static const Color bottombar = Color(0xFFB9BFD4);
  static const Color headingColor = Color(0xFF3D5090);


}

LinearGradient gredient(){
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF347DBA),
      Color(0xFF3D5090),
    ],
  );
}


LinearGradient gredientBottomSheet(){
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFB8BFD7),
      Color(0xFFDBDEEA),

    ],
  );
}


LinearGradient amountcard(){
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF7AD7F0),
      Color(0xFF7AD7F0),
      Color(0xFFF5FCFF),
    ],
  );
}
