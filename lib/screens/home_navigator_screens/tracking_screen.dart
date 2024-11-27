import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_car_owner/controller/home_navigator/tracking_screen_controller.dart';
import 'package:one_ride_car_owner/utils/app_singleton.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackingScreenController>(
        init: TrackingScreenController(),
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false,
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: false,
                titleWidget: const Text(
                  '',
                  style: AppTextStyles.titleBoldTextStyle,
                ),
                leading: Center(
                  child: IconButtonWidget(
                    backgroundColor: AppColors.appBarIconTextColor,
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
                            color: AppColors.mainTextColor)),
                  ),
                ),
                actions: [
                  Center(
                    child: IconButtonWidget(
                      backgroundColor: AppColors.appBarIconTextColor,
                      onTap: () {
                        Get.toNamed(AppPageNames.notificationScreen,
                            arguments: true);
                      },
                      child: const SizedBox(
                          height: 24,
                          width: 24,
                          child: SvgPictureAssetWidget(
                              AppAssetImages.notificationButtonSVGLogoLine,
                              color: AppColors.mainTextColor)),
                    ),
                  ),
                  AppGaps.wGap24
                ],
              ),
              body: Stack(
                children: [
                  Positioned.fill(
                    child: GoogleMap(
                      mapType: MapType.normal,
                      mapToolbarEnabled: false,
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      compassEnabled: true,
                      zoomGesturesEnabled: true,
                      initialCameraPosition:
                          AppSingleton.instance.defaultCameraPosition,
                      markers: controller.googleMapMarkers,
                      polylines: controller.googleMapPolylines,
                      onMapCreated: controller.onGoogleMapCreated,
                      onTap: controller.onGoogleMapTap,
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      left: 24,
                      right: 24,
                      child: SizedBox(
                        height: 170,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Positioned(
                              top: 36,
                              child: IconButtonWidget(
                                backgroundColor: Colors.white,
                                onTap: () {},
                                child: const SvgPictureAssetWidget(
                                    AppAssetImages.locationSVGLogoLine,
                                    color: AppColors.primaryColor),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ));
  }
}
