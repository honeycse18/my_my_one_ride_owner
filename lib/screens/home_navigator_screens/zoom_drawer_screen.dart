import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/drawer_screen_controller.dart';
import 'package:one_ride_car_owner/screens/home_navigator_screens/menu_screen.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';

class ZoomDrawerScreen extends StatelessWidget {
  const ZoomDrawerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoomDrawerScreenController>(
      global: false,
      init: ZoomDrawerScreenController(),
      builder: (controller) => Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: ZoomDrawer(
          menuBackgroundColor: AppColors.primaryColor.withOpacity(0.5),
          controller: controller.zoomDrawerController,
          menuScreen: const MenuScreen(),
          mainScreen: controller.nestedScreenWidget,
          showShadow: true,
          style: DrawerStyle.defaultStyle,
          angle: 0.0,
          isRtl: false,
        ),
        bottomNavigationBar: SafeArea(
            child: SizedBox(
          height: 75,
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 15),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(65)),
              child: BottomAppBar(
                color: AppColors.primaryColor,
                shadowColor: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: controller.bottomMenuButton(
                              AppLanguageTranslation
                                  .homeTransKey.toCurrentLanguage,
                              AppAssetImages.homeSVGLogoLine,
                              0),
                        ),
                        /* controller.bottomMenuButton('Tracking',
                            AppAssetImages.multiplePeopleSVGLogoLine, 1), */
                        Expanded(
                          child: controller.bottomMenuButton(
                              AppLanguageTranslation
                                  .historyTransKey.toCurrentLanguage,
                              AppAssetImages.historySVGLogoLine,
                              2),
                        ),
                        Expanded(
                          child: controller.bottomMenuButton(
                              AppLanguageTranslation
                                  .messageTransKey.toCurrentLanguage,
                              AppAssetImages.messageSVGLogoLine,
                              3),
                        ),
                        Expanded(
                          child: controller.bottomMenuButton(
                              AppLanguageTranslation
                                  .walletTransKey.toCurrentLanguage,
                              AppAssetImages.walletSVGLogoLine,
                              4),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
