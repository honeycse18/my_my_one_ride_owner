import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';

class ServiceReminderCard {
  String title;
  int count;
  String icon;
  Color iconBackgroundColor;
  Color cardBackgroundColor;
  bool isShowMoneySymbol;
  ServiceReminderCard(
      {required this.title,
      this.count = 0,
      required this.icon,
      this.iconBackgroundColor = AppColors.primaryColor,
      this.cardBackgroundColor = AppColors.secondaryTextColor,
      this.isShowMoneySymbol = false});
}
