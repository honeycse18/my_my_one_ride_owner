import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/models/enums.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class AddVehicleTabWidget extends StatelessWidget {
  final int tabIndex;
  final String tabName;
  final bool isLine;
  final AddVehicleTabState currentTabState;
  final AddVehicleTabState myTabState;
  const AddVehicleTabWidget({
    super.key,
    required this.tabIndex,
    required this.tabName,
    this.isLine = false,
    this.currentTabState = AddVehicleTabState.step1,
    required this.myTabState,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (tabIndex != 1)
              Expanded(
                  child: DottedHorizontalLine(
                dashColor: _getTabStateColor(myTabState, currentTabState),
              )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPictureAssetWidget(
                  AppAssetImages.radioButtonSVGLogoLine,
                  color: _getTabStateColor(myTabState, currentTabState),
                ),
                AppGaps.hGap2,
                Text(
                  tabName,
                  style: AppTextStyles.bodyMediumTextStyle.copyWith(
                      color: _getTabStateColor(myTabState, currentTabState)),
                ),
              ],
            ),
            if (tabIndex != 3)
              Expanded(
                  child: DottedHorizontalLine(
                dashColor: _getTabStateColor(myTabState, currentTabState),
              ))
          ],
        ));
  }

  Widget _getTabStatePrefixIconWidget(AddVehicleTabState tabState) {
    // ignore: unrelated_type_equality_checks
    if (tabState == AddVehicleDetailsTabState.completed) {
      return const LocalAssetSVGIcon(AppAssetImages.tickIconSVG,
          color: Colors.white, height: 4.81);
    }
    return Text(
      '$tabIndex',
      style:
          AppTextStyles.smallestMediumTextStyle.copyWith(color: Colors.white),
    );
  }

  Color _getTabStateColor(
      AddVehicleTabState myTabState, AddVehicleTabState currentTabState) {
    const Color inactiveStateColor = AppColors.primaryColor;
    Color currentTabStateColor = inactiveStateColor;
    switch (myTabState) {
      case AddVehicleTabState.step1:
        if (currentTabState == AddVehicleTabState.step1) {
          currentTabStateColor = AppColors.greyColor;
        } else if (currentTabState == AddVehicleTabState.step2) {
          currentTabStateColor = AppColors.greyColor;
        } else if (currentTabState == AddVehicleTabState.step3) {
          currentTabStateColor = AppColors.greyColor;
        } else {
          currentTabStateColor = inactiveStateColor;
        }
        break;
      case AddVehicleTabState.step2:
        if (currentTabState == AddVehicleTabState.step1) {
          currentTabStateColor = inactiveStateColor;
        } else if (currentTabState == AddVehicleTabState.step2) {
          currentTabStateColor = AppColors.greyColor;
        } else if (currentTabState == AddVehicleTabState.step3) {
          currentTabStateColor = AppColors.greyColor;
        } else {
          currentTabStateColor = inactiveStateColor;
        }
        break;
      case AddVehicleTabState.step3:
        if (currentTabState == AddVehicleTabState.step1) {
          currentTabStateColor = inactiveStateColor;
        } else if (currentTabState == AddVehicleTabState.step2) {
          currentTabStateColor = inactiveStateColor;
        } else if (currentTabState == AddVehicleTabState.step3) {
          currentTabStateColor = AppColors.greyColor;
        } else {
          currentTabStateColor = inactiveStateColor;
        }
        break;
      default:
        currentTabStateColor = AppColors.greyColor;
    }
    return currentTabStateColor;
  }
}
