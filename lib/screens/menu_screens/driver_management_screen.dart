import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/driver_management_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/add_driver_list_response.dart';
import 'package:one_ride_car_owner/screens/bottom_sheet/add_driver_bottom_sheet_screen.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/added_driver_list_widget.dart';

class DriverManagementScreen extends StatelessWidget {
  const DriverManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverManagementScreenController>(
        init: DriverManagementScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleWidget: Text(AppLanguageTranslation
                    .driverManagementTransKey.toCurrentLanguage),
              ),
              body: ScaffoldBodyWidget(
                  child: RefreshIndicator(
                onRefresh: () async =>
                    controller.driverListPagingController.refresh(),
                child: CustomScrollView(
                  slivers: [
                    /* <---- Top extra spaces ----> */
                    const SliverToBoxAdapter(child: AppGaps.hGap10),
                    SliverToBoxAdapter(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color:
                                AppColors.appBarIconTextColor.withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18))),
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
                                          .activeTransKey.toCurrentLanguage,
                                      isSelected:
                                          !controller.isAcceptedSelected.value,
                                      onTap: () {
                                        controller.isAcceptedSelected.value =
                                            false;
                                        controller.driverListPagingController
                                            .refresh();
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
                                          .pendingTransKey.toCurrentLanguage,
                                      isSelected:
                                          controller.isAcceptedSelected.value,
                                      onTap: () {
                                        controller.isAcceptedSelected.value =
                                            true;
                                        controller.driverListPagingController
                                            .refresh();
                                      })),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap15,
                    ),
                    Obx(() => !controller.isAcceptedSelected.value
                        ? PagedSliverList.separated(
                            pagingController:
                                controller.driverListPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<AddedDriverListItem>(
                              noItemsFoundIndicatorBuilder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                        isSVGImage: true,
                                        localImageAssetURL:
                                            AppAssetImages.driveSVGLogoLine,
                                        title: AppLanguageTranslation
                                            .noDriverAddTransKey
                                            .toCurrentLanguage),
                                  ],
                                );
                              },
                              itemBuilder: (context, item, index) {
                                final AddedDriverListItem addedDriverList =
                                    item;
                                return AddedDriverListItemWidget(
                                  onTap: () async {
                                    await Get.toNamed(
                                        AppPageNames.driverDetailsScreen,
                                        arguments: addedDriverList);
                                    controller.driverListPagingController
                                        .refresh();
                                  },
                                  driverImage: addedDriverList.driver.image,
                                  driverName: addedDriverList.driver.name,
                                  driverUid: addedDriverList.driver.uid,
                                );
                              },
                            ),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap24,
                          )
                        : PagedSliverList.separated(
                            pagingController:
                                controller.driverListPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<AddedDriverListItem>(
                              noItemsFoundIndicatorBuilder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                        isSVGImage: true,
                                        localImageAssetURL:
                                            AppAssetImages.driveSVGLogoLine,
                                        title: AppLanguageTranslation
                                            .noDriverAddTransKey
                                            .toCurrentLanguage),
                                  ],
                                );
                              },
                              itemBuilder: (context, item, index) {
                                final AddedDriverListItem addedDriverList =
                                    item;
                                return AddedDriverListItemWidget(
                                  /* onTap: () async {
                                    /*  await Get.toNamed(
                                        AppPageNames.driverDetailsScreen,
                                        arguments: addedDriverList);
                                    controller.driverListPagingController
                                        .refresh(); */
                                  }, */
                                  driverImage: addedDriverList.driver.image,
                                  driverName: addedDriverList.driver.name,
                                  driverUid: addedDriverList.driver.uid,
                                );
                              },
                            ),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap24,
                          )),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap80,
                    ),
                  ],
                ),
              )),
              floatingActionButton: FloatingActionButton.extended(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14.0))),
                onPressed: () async {
                  await Get.bottomSheet(const AddDriverBottomSheet(),
                      isScrollControlled: true, ignoreSafeArea: false);
                  controller.driverListPagingController.refresh();
                },
                label: Text(
                    AppLanguageTranslation.addDriverTransKey.toCurrentLanguage,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle
                        .copyWith(color: Colors.white)),
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ));
  }
}
