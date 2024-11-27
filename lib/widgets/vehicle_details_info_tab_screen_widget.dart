import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class VehicleDetailsInfoTabStatusWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function()? onTap;

  const VehicleDetailsInfoTabStatusWidget(
      {super.key, required this.text, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      borderRadiusValue: 8,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        // margin: EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          // border: Border(bottom: BorderSide(color: Colors.black)),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          // border: ,
        ),
        child: Text(text,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: isSelected
                ? AppTextStyles.bodyLargeMediumTextStyle
                    .copyWith(color: Colors.black)
                : AppTextStyles.bodyLargeTextStyle
                    .copyWith(color: AppColors.bodyTextColor)),
      ),
    );
  }
}
