import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';

/// This file contain theme data of the app and initial custom default widget
/// configurations
class AppThemeData {
  static final ThemeData appThemeData = ThemeData(
      // Set default font name

      useMaterial3: false,
      fontFamily: 'SF Pro Display',
      primarySwatch: AppColors.primaryMaterialColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.transparent,
      // Setting all default textTheme based on design
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 36,
            color: AppColors.mainTextColor,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            fontSize: 26,
            color: AppColors.mainTextColor,
            fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            fontSize: 24,
            color: AppColors.mainTextColor,
            fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            fontSize: 20,
            color: AppColors.mainTextColor,
            fontWeight: FontWeight.bold),
        labelLarge: TextStyle(
            fontSize: 18,
            color: AppColors.mainTextColor,
            fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(
            fontSize: 16,
            color: AppColors.mainTextColor,
            fontWeight: FontWeight.w400),
        bodySmall: TextStyle(
            fontSize: 14,
            color: AppColors.mainTextColor,
            fontWeight: FontWeight.w400),
      ),
      // Set default TextField theme design
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: AppColors.primaryColor,
          filled: true,
          hintStyle: TextStyle(color: AppColors.mainTextColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(AppComponents.defaultBorderRadius),
              borderSide:
                  BorderSide(color: AppColors.lineShapeColor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(AppComponents.defaultBorderRadius),
              borderSide:
                  BorderSide(color: AppColors.lineShapeColor, width: 1))),
      // Set default appbar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 24,
            fontFamily: 'SF Pro Display',
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.primaryColor.withOpacity(.32);
          }
          return AppColors.primaryColor;
        }),
      ),
      popupMenuTheme: const PopupMenuThemeData(
          color: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          textStyle: TextStyle(
              color: AppColors.darkColor,
              fontSize: 14,
              fontWeight: FontWeight.w500)));
}
