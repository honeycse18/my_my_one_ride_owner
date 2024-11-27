import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/home_navigator/menu_screen_controller.dart';
import 'package:one_ride_car_owner/screens/home_navigator_screens/drawer_address.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuScreenController>(
        global: false,
        init: MenuScreenController(),
        builder: (controller) => Scaffold(
              // backgroundColor: Color(0xffFFFCEC),
              body: SafeArea(
                child: Center(
                  child: CustomScaffoldBodyWidget(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppGaps.hGap40,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 95,
                                width: 95,
                                child: CachedNetworkImageWidget(
                                  imageURL: controller.userDetails.image,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AppGaps.hGap20,
                          RawButtonWidget(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Text(controller.userDetails.name,
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles
                                            .bodyExtraLargeSemiboldTextStyle
                                            .copyWith(
                                                color:
                                                    AppColors.mainTextColor))),
                              ],
                            ),
                            onTap: () async {
                              await Get.toNamed(AppPageNames.myAccountScreen);
                              controller.getUserDetails();
                            },
                          ),
                          AppGaps.hGap80,

                          DrawerMenuSvgWidget(
                              text: AppLanguageTranslation
                                  .profileTransKey.toCurrentLanguage,
                              localAssetIconName:
                                  AppAssetImages.userProfileSvgFillIcon,
                              color: AppColors.mainTextColor,
                              onTap: () async {
                                await Get.toNamed(AppPageNames.myAccountScreen);
                                controller.getUserDetails();
                                controller.update();
                              }),
                          AppGaps.hGap22,
                          DrawerMenuSvgWidget(
                              text: AppLanguageTranslation
                                  .mySubscriptionsTransKey.toCurrentLanguage,
                              localAssetIconName:
                                  AppAssetImages.mySubsSVGLogoLine,
                              color: AppColors.mainTextColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.mySubscriptionsScreen);
                              }),
                          AppGaps.hGap22,
                          DrawerMenuSvgWidget(
                              text: AppLanguageTranslation
                                  .subscriptionsTransKey.toCurrentLanguage,
                              localAssetIconName:
                                  AppAssetImages.convertCardSvgFillIcon,
                              color: AppColors.mainTextColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.subscriptionScreen);
                              }),

                          AppGaps.hGap22,
                          DrawerMenuSvgWidget(
                              text: AppLanguageTranslation
                                  .vehicleTransKey.toCurrentLanguage,
                              color: AppColors.mainTextColor,
                              localAssetIconName: AppAssetImages.carSvgFillIcon,
                              onTap: () {
                                Get.toNamed(AppPageNames.vehicleScreen);
                              }),
                          AppGaps.hGap22,
                          DrawerMenuSvgWidget(
                              text: AppLanguageTranslation
                                  .driverTransKey.toCurrentLanguage,
                              localAssetIconName:
                                  AppAssetImages.driverSvgFillIcon,
                              color: AppColors.mainTextColor,
                              onTap: () {
                                Get.toNamed(
                                    AppPageNames.driverManagementScreen);
                              }),
                          /* AppGaps.hGap22,
                          DrawerMenuSvgWidget(
                              text: 'Rent Management',
                              localAssetIconName:
                                  AppAssetImages.arrowDownSVGLogoLine,
                              color: AppColors.primaryColor,
                              onTap: () {
                                // Get.toNamed(AppPageNames.myOrdersScreen);
                              }), */
                          AppGaps.hGap22,
                          DrawerMenuSvgWidget(
                              text: AppLanguageTranslation
                                  .hireADriverTransKey.toCurrentLanguage,
                              localAssetIconName:
                                  AppAssetImages.hireDriverSvgFillIcon,
                              color: AppColors.mainTextColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.hireDriverScreen);
                                // controller.getUser();
                                // Get.find<HomeScreenController>().getUser();
                              }),
                          AppGaps.hGap22,
                          DrawerMenuSvgWidget(
                              text: AppLanguageTranslation
                                  .rentRideManagementTransKey.toCurrentLanguage,
                              localAssetIconName:
                                  AppAssetImages.rideRentSvgFillIcon,
                              color: AppColors.mainTextColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.rentRideScreen);
                                // controller.getUser();
                                // Get.find<HomeScreenController>().getUser();
                              }),
                          AppGaps.hGap22,
                          DrawerMenuSvgWidget(
                              text: AppLanguageTranslation
                                  .fleetManagementTransKey.toCurrentLanguage,
                              localAssetIconName:
                                  AppAssetImages.fleetSvgFillIcon,
                              color: AppColors.mainTextColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.fleetManagementScreen);
                              }),
                          /* AppGaps.hGap22,
                          DrawerMenuSvgWidget(
                              text: 'Report',
                              localAssetIconName:
                                  AppAssetImages.clipBoardSvgFillIcon,
                              color: AppColors.mainTextColor,
                              onTap: () {
                                // AppDialogs.showConfirmDialog(
                                //   messageText: AppLanguageTranslations
                                //       .doYouWantToLogOutTransKey.toCurrentLanguage,
                                //   onYesTap: () async {
                                //     Helper.logout();
                                //   },
                                // );
                              }), */

                          AppGaps.hGap22,
                          DrawerMenuSvgWidget(
                              text: AppLanguageTranslation
                                  .aboutUsTransKey.toCurrentLanguage,
                              localAssetIconName:
                                  AppAssetImages.informationSvgFillIcon,
                              color: AppColors.mainTextColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.aboutUsScreen);
                              }),
                          AppGaps.hGap20,
                          DrawerMenuSvgWidget(
                              text: AppLanguageTranslation
                                  .settingsTransKey.toCurrentLanguage,
                              localAssetIconName:
                                  AppAssetImages.settingsSvgFillIcon,
                              color: AppColors.mainTextColor,
                              onTap: () async {
                                await Get.toNamed(AppPageNames.settingsScreen);
                                controller.update();
                              }),
                          AppGaps.hGap22,
                          DrawerMenuSvgWidget(
                              text: AppLanguageTranslation
                                  .helpSupportTransKey.toCurrentLanguage,
                              localAssetIconName:
                                  AppAssetImages.supportSvgFillIcon,
                              color: AppColors.mainTextColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.helpSupportScreen);
                                // AppDialogs.showConfirmDialog(
                                //   messageText: AppLanguageTranslations
                                //       .doYouWantToLogOutTransKey.toCurrentLanguage,
                                //   onYesTap: () async {
                                //     Helper.logout();
                                //   },
                                // );
                              }),
                          AppGaps.hGap22,
                          DrawerMenuSvgWidget(
                              text: AppLanguageTranslation
                                  .logoutTransKey.toCurrentLanguage,
                              localAssetIconName:
                                  AppAssetImages.logoutButtonSVGLogoLine,
                              color: AppColors.mainTextColor,
                              onTap: controller.onLogOutButtonTap),
                          AppGaps.hGap22,

                          // Bottom extra spaces
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
