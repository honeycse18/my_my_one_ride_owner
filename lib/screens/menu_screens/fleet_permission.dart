import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/fleet_driver_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class FleetPermissionDriverScreen extends StatelessWidget {
  const FleetPermissionDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FleetPermissionDriverScreenController>(
        init: FleetPermissionDriverScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .fleetDriverTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppGaps.hGap10,
                  Text(
                    AppLanguageTranslation
                        .doYouHaveFleetPermissionTransKey.toCurrentLanguage,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle,
                  ),
                  AppGaps.hGap8,
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(18),
                        height: 62,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: AppColors.primaryColor),
                        child: Center(
                          child: Obx(() => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller
                                            .addedDriverListDetails.value.fleet
                                        ? AppLanguageTranslation
                                            .yesAllowedTransKey
                                            .toCurrentLanguage
                                        : AppLanguageTranslation
                                            .noAllowedTransKey
                                            .toCurrentLanguage,
                                    style: AppTextStyles
                                        .bodyLargeSemiboldTextStyle,
                                  ),
                                  SwitchWidget(
                                      value: controller.isFleetActive.value,
                                      onToggle: (value) =>
                                          controller.toggleFleetChanges(value)),
                                ],
                              )),
                        ),
                      )),
                    ],
                  ),
                  AppGaps.hGap16,
                  Text(
                    AppLanguageTranslation
                        .doYouHaveFleetPermissionTransKey.toCurrentLanguage,
                    style: AppTextStyles.bodySmallTextStyle
                        .copyWith(color: Colors.red),
                  )
                ],
              )),
            ));
  }
}
