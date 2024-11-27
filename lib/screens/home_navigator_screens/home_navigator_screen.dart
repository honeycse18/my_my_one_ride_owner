import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/home_navigator/home_navigator_screen_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class HomeNavigatorScreen extends StatelessWidget {
  const HomeNavigatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeNavigatorScreenController>(
        global: false,
        init: HomeNavigatorScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: false,
                leading: Center(
                  child: IconButtonWidget(
                    backgroundColor: Colors.white,
                    onTap: () {
                      if (ZoomDrawer.of(context)!.isOpen()) {
                        ZoomDrawer.of(context)!.close();
                      } else {
                        ZoomDrawer.of(context)!.open();
                      }
                    },
                    child: const SizedBox(
                        height: 24,
                        width: 24,
                        child: SvgPictureAssetWidget(
                            AppAssetImages.menuButtonSVGLogoLine,
                            color: AppColors.primaryColor)),
                  ),
                ),
                actions: [
                  Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: IconButtonWidget(
                          child: const SvgPictureAssetWidget(
                            AppAssetImages.notificationButtonSVGLogoLine,
                            height: 20,
                            width: 20,
                            color: AppColors.primaryColor,
                          ),
                          onTap: () {
                            Get.toNamed(AppPageNames.notificationScreen,
                                arguments: true);
                          }),
                    ),
                  ),
                  AppGaps.wGap24
                ],
              ),
              body: controller.nestedScreenWidget,
            ));
  }
}
