import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/home_navigator/driver_details_screen_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/settings_screen_widgets.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class DriverDetailsScreen extends StatelessWidget {
  const DriverDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverDetailsScreenController>(
        global: false,
        init: DriverDetailsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget:
                      Text(controller.addedDriverListDetails.driver.uid)),
              body: ScaffoldBodyWidget(
                  child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap10,
                      Center(
                        child: Container(
                          height: 138,
                          width: 138,
                          decoration: BoxDecoration(
                              borderRadius: AppComponents.imageBorderRadius,
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                          child: CachedNetworkImageWidget(
                            imageURL:
                                controller.addedDriverListDetails.driver.image,
                            imageBuilder: (context, imageProvider) => Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: AppComponents.imageBorderRadius,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ),
                      AppGaps.hGap16,
                      Center(
                        child: Text(
                          controller.addedDriverListDetails.driver.name,
                          style: AppTextStyles.titleLargeBoldTextStyle,
                        ),
                      ),
                      AppGaps.hGap24,
                      const Center(
                        child: DottedHorizontalLine(
                          dashColor: AppColors.bodyTextColor,
                          dashGapLength: 5,
                          dashLength: 10,
                        ),
                      ),
                      AppGaps.hGap24,
                      Text(
                        AppLanguageTranslation
                            .permissionTransKey.toCurrentLanguage,
                        style: AppTextStyles.titleSemiSmallMediumTextStyle,
                      ),
                      AppGaps.hGap16,
                      SettingsListTileWidget(
                          titleText: AppLanguageTranslation
                              .fleetDriverTransKey.toCurrentLanguage,
                          onTap: () {
                            Get.toNamed(
                                AppPageNames.fleetPermissionDriverScreen,
                                arguments: controller.addedDriverListDetails);
                          }),
                      /* AppGaps.hGap24,
                      const Text(
                        'Performance',
                        style: AppTextStyles.titleSemiSmallMediumTextStyle,
                      ),
                      AppGaps.hGap16,
                      SettingsListTileWidget(
                          titleText: 'Driver Performance',
                          onTap: () {
                            // Get.toNamed(AppPageNames.privacyPolicyScreen);
                          }), */
                      AppGaps.hGap24,
                      const Text(
                        'Action',
                        style: AppTextStyles.titleSemiSmallMediumTextStyle,
                      ),
                      AppGaps.hGap16,
                      SettingsListTileWidget(
                          showRightArrow: false,
                          titleText: 'Remove this Driver',
                          onTap: () => controller.removeThisDriver(
                              controller.addedDriverListDetails.id)),
                      AppGaps.hGap16,
                    ]),
              )),
            ));
  }
}
