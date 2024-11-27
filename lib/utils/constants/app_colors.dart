import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';

/// This file contains custom colors used throughout the app
class AppColors {
  static const Color primaryColor = Color(0xff262626);
  static const Color mainTextColor = Color(0xffffffff);
  static const Color appBarIconTextColor = Color(0xff1F222A);
  static const Color navBarIconColor = Color(0xFF0766AD);
  // static const Color primaryColor = Color(0xfff79b39);
  static const Color secondaryBodyTextColor = Color(0xFF181059);
  static const Color primaryBorderColor = Color(0xFFEBEDF8);
  static const Color secondaryColor = Color(0xFFF79C39);
  static const Color tertiaryColor = Color(0xFF4BCBF9);
  static const Color successColor = Color(0xFF48E98A);
  static const Color alertColor = Color(0xFFFE4651);
  static const Color darkColor = Color(0xFF292B49);
  static const Color dividerColor = Color(0xFFCED7E2);
  static const Color bodyTextColor = Color(0xFF888AA0);
  static const Color lineShapeColor = Color(0xFF272837);
  // static const Color lineShapeColor = Color(0xFFEBEDF9);
  static const Color shadeColor1 = Color(0xFFF4F5FA);
  static const Color mainBg = Color(0xFF000000);
  // static const Color mainBg = Color(0xFFF7F7FB);
  static const Color rideColor = Color(0xFF1AB0B0);
  static const Color rentColor = Color(0xFF8676FE);
  static const Color lightgreenColor = Color(0xFF22C55E);
  static const Color secondaryTextColor = Color(0xFF3D3E4C);
  static const Color secondarybodyTextColor = Color(0xFFE9EEF8);

  static const Color successBackgroundColor = Color(0xFFEEF9E8);
  static const Color alertBackgroundColor = Color(0xFFFFEDED);
  static const Color shimmerBaseColor = Color(0xFFCED7E2);
  static const Color shimmerHighlightColor = AppColors.lineShapeColor;
  static const Color greyColor = Color(0xFFD8D5D5);
  static const Color lightGreyColor = Color(0xFFE5E4E3);
  static const Color secondaryButtonFont = Color(0xFF1F222A);

  /// Custom MaterialColor from Helper function
  static final MaterialColor primaryMaterialColor =
      Helper.generateMaterialColor(AppColors.primaryColor);
}
