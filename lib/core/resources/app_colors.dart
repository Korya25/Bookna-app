import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xffef233c);
  static const secondary = Color(0xff272b30);
  static const primaryBackground = Color(0xff1a1d1f);
  static const secondaryBackground = Color(0xff272b30);
  static const primaryText = Color(0xffa9aaac);
  static const secondaryText = Colors.white;
  static const primaryBtnText = Colors.white;
  static const error = Colors.red;
  static const black = Colors.black;
  static const transparent = Colors.transparent;

  // Dot Indicator
  static const circleDotColor = Color(0x33ffffff);
  static const inactiveColor = Color(0x26ffffff);

  // Icon
  static const ratingIconColor = Color(0xffffbe21);
  static const iconContainerColor = Color(0xB2272830);
}

Color getRatingColor(int stars) {
  switch (stars) {
    case 1:
      return Colors.red;
    case 2:
      return Colors.orange;
    case 3:
      return Colors.yellow[700]!;
    case 4:
      return Colors.lightGreen;
    case 5:
      return Colors.green;
    default:
      return Colors.grey;
  }
}
