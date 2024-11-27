import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/home_navigator/rent_ride_management_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_vehicle_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/ride_car_list_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/rent_vehicle_list_widget.dart';

class RentRideManagementScreen extends StatelessWidget {
  const RentRideManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RentRideScreenControllerScreenController>(
        init: RentRideScreenControllerScreenController(),
        builder: (controller) => Scaffold(
            backgroundColor: AppColors.mainBg,
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: true,
                titleWidget: Text(AppLanguageTranslation
                    .rentRideManagementTransKey.toCurrentLanguage)),
            body: ScaffoldBodyWidget(
              child: RefreshIndicator(
                onRefresh: () async {
                  if (!controller.isRideTabSelected.value) {
                    controller.rentVehiclePagingController.refresh();
                  } else {
                    controller.rideVehiclePagingController.refresh();
                  }
                },
                child: CustomScrollView(
                  slivers: [
                    /* <---- Top extra spaces ----> */
                    const SliverToBoxAdapter(child: AppGaps.hGap10),
                    SliverToBoxAdapter(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color:
                                AppColors.appBarIconTextColor.withOpacity(0.8),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /* <---- Product Active Auctions tab button ----> */
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 58,
                                  child: Obx(() => CustomTabToggleButtonWidget(
                                      text: AppLanguageTranslation
                                          .rentTransKey.toCurrentLanguage,
                                      isSelected:
                                          !controller.isRideTabSelected.value,
                                      onTap: () {
                                        controller.isRideTabSelected.value =
                                            false;
                                        controller.update();
                                      })),
                                ),
                              ),
                            ),
                            AppGaps.wGap5,
                            /* <---- Product Won Auctions tab button ----> */
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 58,
                                  child: Obx(() => CustomTabToggleButtonWidget(
                                      text: AppLanguageTranslation
                                          .rideTransKey.toCurrentLanguage,
                                      isSelected:
                                          controller.isRideTabSelected.value,
                                      onTap: () {
                                        controller.isRideTabSelected.value =
                                            true;
                                        controller.update();
                                      })),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: AppGaps.hGap24),
                    Obx(() => !controller.isRideTabSelected.value
                        ? PagedSliverList.separated(
                            pagingController:
                                controller.rentVehiclePagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<RentVehicleItems>(
                              noItemsFoundIndicatorBuilder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                      height: 110,
                                      isSVGImage: true,
                                      localImageAssetURL:
                                          AppAssetImages.carRentSVGLogoSolid,
                                      title: AppLanguageTranslation
                                          .noVehicleTransKey.toCurrentLanguage,
                                      shortTitle: AppLanguageTranslation
                                          .addVehicleTransKey.toCurrentLanguage,
                                    ),
                                  ],
                                );
                              },
                              itemBuilder: (context, item, index) {
                                final RentVehicleItems rentVehicleList = item;
                                return RentVehicleListItemWidget(
                                  onDeletTap: () async {
                                    await controller
                                        .deletRentChanges(rentVehicleList.id);
                                    controller.rideVehiclePagingController
                                        .refresh();
                                  },
                                  onTap: () async {
                                    //--------Edit Tap-------------
                                    await Get.toNamed(
                                        AppPageNames.addRentScreen,
                                        arguments: rentVehicleList.id);
                                    controller.rentVehiclePagingController
                                        .refresh();
                                  },
                                  onEditTap: () async {
                                    //--------Edit Tap-------------
                                    await Get.toNamed(
                                        AppPageNames.addRentScreen,
                                        arguments: rentVehicleList.id);
                                    controller.rentVehiclePagingController
                                        .refresh();
                                  },
                                  isActive: rentVehicleList.active,
                                  onToggleTap: (value) =>
                                      controller.toggleRentChanges(
                                          value, rentVehicleList),
                                  carName: rentVehicleList.vehicle.name,
                                  carNumber:
                                      rentVehicleList.vehicle.vehicleNumber,
                                  carImage: rentVehicleList
                                          .vehicle.images.firstOrNull ??
                                      '',
                                  isRent:
                                      rentVehicleList.vehicle.name.isNotEmpty,
                                );
                              },
                            ),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap24,
                          )
                        : PagedSliverList.separated(
                            pagingController:
                                controller.rideVehiclePagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<RideCarListItems>(
                              noItemsFoundIndicatorBuilder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                      height: 110,
                                      isSVGImage: true,
                                      localImageAssetURL:
                                          AppAssetImages.carRentSVGLogoSolid,
                                      title: AppLanguageTranslation
                                          .noVehicleTransKey.toCurrentLanguage,
                                      shortTitle: AppLanguageTranslation
                                          .addVehicleTransKey.toCurrentLanguage,
                                    ),
                                  ],
                                );
                              },
                              itemBuilder: (context, item, index) {
                                final RideCarListItems rideVehicleList = item;
                                return RentVehicleListItemWidget(
                                  onDeletTap: () async {
                                    await controller
                                        .deletRideChanges(rideVehicleList.id);
                                    controller.rideVehiclePagingController
                                        .refresh();
                                  },
                                  onTap: () async {
                                    //--------Edit Tap-------------

                                    await Get.toNamed(
                                        AppPageNames.addRideScreen,
                                        arguments: rideVehicleList.id);
                                    controller.rideVehiclePagingController
                                        .refresh();
                                  },
                                  onEditTap: () async {
                                    //--------Edit Tap-------------

                                    await Get.toNamed(
                                        AppPageNames.addRideScreen,
                                        arguments: rideVehicleList.id);
                                    controller.rideVehiclePagingController
                                        .refresh();
                                  },
                                  isActive: rideVehicleList.active,
                                  onToggleTap: (value) =>
                                      controller.toggleRideChanges(
                                          value, rideVehicleList),
                                  carName: rideVehicleList.vehicle.name,
                                  carNumber:
                                      rideVehicleList.vehicle.vehicleNumber,
                                  carImage: rideVehicleList
                                          .vehicle.images.firstOrNull ??
                                      '',
                                  isRent:
                                      rideVehicleList.vehicle.name.isNotEmpty,
                                );
                              },
                            ),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap24,
                          ))
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))),
              onPressed: () async {
                controller.isRideTabSelected.value
                    ? await Get.toNamed(AppPageNames.addRideScreen)
                    : await Get.toNamed(AppPageNames.addRentScreen);
                !controller.isRideTabSelected.value
                    ? controller.rideVehiclePagingController.refresh()
                    : controller.rideVehiclePagingController.refresh();
              },
              label: Text(
                  controller.isRideTabSelected.value
                      ? AppLanguageTranslation.addRideTransKey.toCurrentLanguage
                      : AppLanguageTranslation
                          .addRentTransKey.toCurrentLanguage,
                  style: AppTextStyles.bodyLargeSemiboldTextStyle
                      .copyWith(color: Colors.white)),
              icon: const Icon(Icons.add, color: Colors.white),
            )));
  }
}
