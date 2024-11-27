/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/settings_screen_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/drawer_address.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsScreenController>(
        init: SettingsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleWidget: const Text('Profile Setting')),
              body: CustomScaffoldBodyWidget(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    /* AppGaps.hGap24,
                    DrawerMenuSvgWidget(
                        text: 'Location',
                        localAssetIconName: AppAssetImages.arrowDownSVGLogoLine,
                        color: AppColors.primaryColor,
                        onTap: () {
                          // Get.toNamed(AppPageNames.locationScreen);
                        }), */
                    AppGaps.hGap24,
                    DrawerMenuSvgWidget(
                        text: 'Language',
                        localAssetIconName:
                            AppAssetImages.historyButtonSVGLogoLine,
                        color: AppColors.primaryColor,
                        onTap: () {
                          Get.toNamed(AppPageNames.languageScreen);
                        }),
                    AppGaps.hGap24,
                    DrawerMenuSvgWidget(
                        text: 'Change Password',
                        localAssetIconName:
                            AppAssetImages.historyButtonSVGLogoLine,
                        color: AppColors.primaryColor,
                        onTap: () {
                          // Get.toNamed(AppPageNames.changePasswordPromptScreen);
                        }),
                    AppGaps.hGap24,
                    DrawerMenuSvgWidget(
                        text: 'Contact Us',
                        localAssetIconName:
                            AppAssetImages.historyButtonSVGLogoLine,
                        color: AppColors.primaryColor,
                        onTap: () {
                          // Get.toNamed(AppPageNames.contactUsScreen);
                        }),
                    AppGaps.hGap24,
                    DrawerMenuSvgWidget(
                        text: 'Terms And Conditions',
                        localAssetIconName:
                            AppAssetImages.historyButtonSVGLogoLine,
                        color: AppColors.primaryColor,
                        onTap: () {
                          // Get.toNamed(AppPageNames.termsConditionScreen);
                        }),
                    AppGaps.hGap24,
                    DrawerMenuSvgWidget(
                        text: 'Privacy Policy',
                        localAssetIconName:
                            AppAssetImages.historyButtonSVGLogoLine,
                        color: AppColors.primaryColor,
                        onTap: () {
                          // Get.toNamed(AppPageNames.privacyPolicyScreen);
                        }),
                    AppGaps.hGap24,
                  ],
                ),
              )),
            ));
  }
}
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/home_navigator/help_support_screen_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/settings_screen_widgets.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  /// Toggle value of notification

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpSupportScreenController>(
        init: HelpSupportScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,

              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .helpSupportTransKey.toCurrentLanguage)),
              /* <-------- Content --------> */
              body: CustomScaffoldBodyWidget(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap16,
                      SettingsListTileWidget(
                          titleText: AppLanguageTranslation
                              .contactUsTransKey.toCurrentLanguage,
                          /* valueWidget: SettingsValueTextWidget(
                              text: controller.currentLanguageText), */
                          onTap: () {
                            Get.toNamed(AppPageNames.contactUsScreen);
                          }),
                      AppGaps.hGap16,
                      SettingsListTileWidget(
                          titleText: AppLanguageTranslation
                              .privacyPolicyTransKey.toCurrentLanguage,
                          /* valueWidget: SettingsValueTextWidget(
                              text: controller.currentLanguageText), */
                          onTap: () {
                            Get.toNamed(AppPageNames.privacyPolicyScreen);
                          }),
                      AppGaps.hGap16,
                      SettingsListTileWidget(
                          titleText: AppLanguageTranslation
                              .termTransKey.toCurrentLanguage,
                          /* valueWidget: SettingsValueTextWidget(
                              text: controller.currentLanguageText), */
                          onTap: () {
                            Get.toNamed(
                              AppPageNames.termsConditionScreen,
                            );
                            // await Get.toNamed(AppPageNames.languageScreen);
                            controller.update();
                          }),
                    ],
                  ),
                ),
              ),
            ));
  }
}
