import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';

class VehicleFeaturesWidget extends StatelessWidget {
  final String featuresName;
  final String featuresValue;
  const VehicleFeaturesWidget({
    super.key,
    required this.featuresName,
    required this.featuresValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          height: 62,
          decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                featuresName,
                style: AppTextStyles.bodyLargeTextStyle
                    .copyWith(color: AppColors.mainTextColor),
              ),
              Text(featuresValue,
                  style: AppTextStyles.bodyLargeMediumTextStyle.copyWith(
                      color: AppColors.mainTextColor.withOpacity(0.6)))
            ],
          )),
        ))
      ],
    );
  }
}
