import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/home_navigator/vehicle_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/car_list_response.dart';
import 'package:one_ride_car_owner/models/enums.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/vehicle_list_pagination_widget.dart';
import 'package:one_ride_car_owner/widgets/vehicle_list_tab_screen_widget.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VehicleScreenController>(
        init: VehicleScreenController(),
        builder: (controller) => Scaffold(
            backgroundColor: AppColors.mainBg,
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: true,
                titleWidget: Text(
                    AppLanguageTranslation.vehicleTransKey.toCurrentLanguage)),
            body: ScaffoldBodyWidget(
              child: RefreshIndicator(
                onRefresh: () async =>
                    controller.vehiclePagingController.refresh(),
                child: CustomScrollView(
                  slivers: [
                    /* <---- Top extra spaces ----> */
                    // const SliverToBoxAdapter(child: AppGaps.hGap10),
                    /* SliverToBoxAdapter(
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            color: Colors.white,
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
                                      text: 'Approve',
                                      isSelected: !controller
                                          .isPendingTabSelected.value,
                                      onTap: () => controller
                                          .isPendingTabSelected
                                          .value = false)),
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
                                      text: 'Pending',
                                      isSelected: controller
                                          .isPendingTabSelected.value,
                                      onTap: () => controller
                                          .isPendingTabSelected
                                          .value = true)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ), */

                    SliverToBoxAdapter(
                        child: SizedBox(
                            height: 50,
                            child: Obx(() => Row(
                                  children: [
                                    Expanded(
                                        child: ListTabStatusWidget(
                                      text: VehicleListStatus
                                          .pending.stringValueForView,
                                      isSelected:
                                          controller.vehicleStatusTab.value ==
                                              VehicleListStatus.pending,
                                      onTap: () {
                                        controller.onTabTap(
                                            VehicleListStatus.pending);
                                      },
                                    )),
                                    AppGaps.wGap10,
                                    Expanded(
                                        child: ListTabStatusWidget(
                                      text: VehicleListStatus
                                          .approved.stringValueForView,
                                      isSelected:
                                          controller.vehicleStatusTab.value ==
                                              VehicleListStatus.approved,
                                      onTap: () {
                                        controller.onTabTap(
                                            VehicleListStatus.approved);
                                      },
                                    )),
                                    AppGaps.wGap10,
                                    Expanded(
                                        child: ListTabStatusWidget(
                                      text: VehicleListStatus
                                          .cancelled.stringValueForView,
                                      isSelected:
                                          controller.vehicleStatusTab.value ==
                                              VehicleListStatus.cancelled,
                                      onTap: () {
                                        controller.onTabTap(
                                            VehicleListStatus.cancelled);
                                      },
                                    )),
                                    AppGaps.wGap10,
                                    Expanded(
                                        child: ListTabStatusWidget(
                                      text: VehicleListStatus
                                          .suspended.stringValueForView,
                                      isSelected:
                                          controller.vehicleStatusTab.value ==
                                              VehicleListStatus.suspended,
                                      onTap: () {
                                        controller.onTabTap(
                                            VehicleListStatus.suspended);
                                      },
                                    )),
                                  ],
                                )))),
                    const SliverToBoxAdapter(child: AppGaps.hGap24),

                    /* switch (controller.vehicleStatusTab.value) {
                        case VehicleListStatus.pending:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.vehiclePagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<VehicleListItem>(
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
                            }, itemBuilder: (context, item, index) {
                              final VehicleListItem vehicleListItemPending =
                                  item;

                              return VehicleListItemWidget(
                                onTap: () => controller.onSingleVehicleItemTap(
                                    vehicleListItemPending.id),
                                carName: vehicleListItemPending.name,
                                carImage:
                                    vehicleListItemPending.images.firstOrNull ??
                                        '',
                                carCategory:
                                    vehicleListItemPending.category.name,
                                carNumber: vehicleListItemPending.vehicleNumber,
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );
                        case VehicleListStatus.approved:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.vehiclePagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<VehicleListItem>(
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
                            }, itemBuilder: (context, item, index) {
                              final VehicleListItem vehicleListItemApproved =
                                  item;

                              return VehicleListItemWidget(
                                onTap: () {
                                  Get.toNamed(AppPageNames.vehicleDetailsScreen,
                                      arguments: vehicleListItemApproved.id);
                                },
                                carName: vehicleListItemApproved.name,
                                carImage: vehicleListItemApproved
                                        .images.firstOrNull ??
                                    '',
                                carCategory:
                                    vehicleListItemApproved.category.name,
                                carNumber:
                                    vehicleListItemApproved.vehicleNumber,
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );
                        case VehicleListStatus.cancelled:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.vehiclePagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<VehicleListItem>(
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
                            }, itemBuilder: (context, item, index) {
                              final VehicleListItem vehicleListItemCancelled =
                                  item;

                              return VehicleListItemWidget(
                                onTap: () {
                                  Get.toNamed(AppPageNames.vehicleDetailsScreen,
                                      arguments: vehicleListItemCancelled.id);
                                },
                                carName: vehicleListItemCancelled.name,
                                carImage: vehicleListItemCancelled
                                        .images.firstOrNull ??
                                    '',
                                carCategory:
                                    vehicleListItemCancelled.category.name,
                                carNumber:
                                    vehicleListItemCancelled.vehicleNumber,
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );
                        case VehicleListStatus.suspended:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.vehiclePagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<VehicleListItem>(
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
                            }, itemBuilder: (context, item, index) {
                              final VehicleListItem vehicleListItemSuspended =
                                  item;

                              return VehicleListItemWidget(
                                onTap: () {
                                  Get.toNamed(AppPageNames.vehicleDetailsScreen,
                                      arguments: vehicleListItemSuspended.id);
                                },
                                carName: vehicleListItemSuspended.name,
                                carImage: vehicleListItemSuspended
                                        .images.firstOrNull ??
                                    '',
                                carCategory:
                                    vehicleListItemSuspended.category.name,
                                carNumber:
                                    vehicleListItemSuspended.vehicleNumber,
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );
                      } */
                    PagedSliverList.separated(
                      pagingController: controller.vehiclePagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<VehicleListItem>(
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
                      }, itemBuilder: (context, item, index) {
                        final VehicleListItem vehicleListItemPending = item;

                        return VehicleListItemWidget(
                          onTap: () => controller.onSingleVehicleItemTap(
                              vehicleListItemPending.id),
                          carName: vehicleListItemPending.name,
                          carImage:
                              vehicleListItemPending.images.firstOrNull ?? '',
                          carCategory: vehicleListItemPending.category.name,
                          carNumber: vehicleListItemPending.vehicleNumber,
                        );
                      }),
                      separatorBuilder: (context, index) => AppGaps.hGap16,
                    ),

                    /* const SliverToBoxAdapter(
                      child: EmptyScreenWidget(
                        height: 110,
                        isSVGImage: true,
                        localImageAssetURL: AppAssetImages.carRentSVGLogoSolid,
                        title: AppLanguageTranslation.noVehicleTransKey.toCurrentLanguage,
                        shortTitle: AppLanguageTranslation.addVehicleTransKey.toCurrentLanguage,
                      ),
                    ) */
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              onPressed: () async {
                await Get.toNamed(AppPageNames.addVehicleScreen);
                controller.vehiclePagingController.refresh();
              },
              label: Text(
                  AppLanguageTranslation.addVehiclesTransKey.toCurrentLanguage,
                  style: AppTextStyles.bodyLargeSemiboldTextStyle
                      .copyWith(color: Colors.white)),
              icon: const Icon(Icons.add, color: Colors.white),
            )));
  }
}
