import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/myhistory_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_history_list_response.dart';
import 'package:one_ride_car_owner/models/enums.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/rent_history_widget.dart';
import 'package:one_ride_car_owner/widgets/vehicle_list_tab_screen_widget.dart';

class MyHistoryListScreen extends StatelessWidget {
  const MyHistoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyHistoryScreenController>(
        init: MyHistoryScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false,
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: false,
                titleWidget:  Text(
                  AppLanguageTranslation.historyTransKey.toCurrentLanguage,
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
              body: ScaffoldBodyWidget(
                  child: SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async =>
                      controller.rentHistoryPagingController.refresh(),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                          child: SizedBox(
                              height: 50,
                              child: Obx(() => SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ListTabStatusWidget(
                                          text: TabStatus
                                              .accepted.stringValueForView,
                                          isSelected: controller
                                                  .vehicleStatusTab.value ==
                                              TabStatus.accepted,
                                          onTap: () {
                                            controller
                                                .onTabTap(TabStatus.accepted);
                                          },
                                        ),
                                        AppGaps.wGap10,
                                        ListTabStatusWidget(
                                          text: TabStatus
                                              .started.stringValueForView,
                                          isSelected: controller
                                                  .vehicleStatusTab.value ==
                                              TabStatus.started,
                                          onTap: () {
                                            controller
                                                .onTabTap(TabStatus.started);
                                          },
                                        ),
                                        AppGaps.wGap10,
                                        ListTabStatusWidget(
                                          text: TabStatus
                                              .cancelled.stringValueForView,
                                          isSelected: controller
                                                  .vehicleStatusTab.value ==
                                              TabStatus.cancelled,
                                          onTap: () {
                                            controller
                                                .onTabTap(TabStatus.cancelled);
                                          },
                                        ),
                                        AppGaps.wGap10,
                                        ListTabStatusWidget(
                                          text: TabStatus
                                              .completed.stringValueForView,
                                          isSelected: controller
                                                  .vehicleStatusTab.value ==
                                              TabStatus.completed,
                                          onTap: () {
                                            controller
                                                .onTabTap(TabStatus.completed);
                                          },
                                        ),
                                      ],
                                    ),
                                  )))),
                      const SliverToBoxAdapter(child: AppGaps.hGap24),
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              AppLanguageTranslation.totalTripsTransKey.toCurrentLanguage,
                              style: AppTextStyles.titleSemiSmallBoldTextStyle,
                            ),
                            Text(
                              AppLanguageTranslation.rentTransKey.toCurrentLanguage,
                              style: AppTextStyles.bodyMediumTextStyle
                                  .copyWith(color: AppColors.mainTextColor),
                            ),
                          ],
                        ),
                      ),
                      const SliverToBoxAdapter(child: AppGaps.hGap24),
                      Obx(() {
                        switch (controller.vehicleStatusTab.value) {
                          case TabStatus.accepted:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.rentHistoryPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<RentHistoryList>(
                                      noItemsFoundIndicatorBuilder: (context) {
                                return  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                      height: 110,
                                      isSVGImage: true,
                                      localImageAssetURL:
                                          AppAssetImages.carRentSVGLogoSolid,
                                      title: AppLanguageTranslation.haveNoRentTransKey.toCurrentLanguage,
                                    ),
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final RentHistoryList vehicleListItemAccepted =
                                    item;

                                return RentHistoryWidget(
                                  onSendTap: () {
                                    Get.toNamed(AppPageNames.chatScreen,
                                        arguments:
                                            vehicleListItemAccepted.user.id);
                                  },
                                  onTap: () async {
                                    await Get.toNamed(
                                        AppPageNames.historyRentDetails,
                                        arguments: vehicleListItemAccepted);
                                    controller.rentHistoryPagingController
                                        .refresh();
                                  },
                                  dateTime: vehicleListItemAccepted.date,
                                  driverImage:
                                      vehicleListItemAccepted.driver.image,
                                  driverNmae:
                                      vehicleListItemAccepted.driver.name,
                                  quantity: vehicleListItemAccepted.quantity,
                                  type: vehicleListItemAccepted.type,
                                  userImage: vehicleListItemAccepted.user.image,
                                  userNmae: vehicleListItemAccepted.user.name,
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );
                          case TabStatus.started:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.rentHistoryPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<RentHistoryList>(
                                      noItemsFoundIndicatorBuilder: (context) {
                                return  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                      height: 110,
                                      isSVGImage: true,
                                      localImageAssetURL:
                                          AppAssetImages.carRentSVGLogoSolid,
                                      title: AppLanguageTranslation.haveNoRentTransKey.toCurrentLanguage,
                                    ),
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final RentHistoryList vehicleListItemAccepted =
                                    item;

                                return RentHistoryWidget(
                                  onSendTap: () {
                                    Get.toNamed(AppPageNames.chatScreen,
                                        arguments:
                                            vehicleListItemAccepted.user.id);
                                  },
                                  onTap: () async {
                                    await Get.toNamed(
                                        AppPageNames.historyRentDetails,
                                        arguments: vehicleListItemAccepted);
                                    controller.rentHistoryPagingController
                                        .refresh();
                                  },
                                  dateTime: vehicleListItemAccepted.date,
                                  driverImage:
                                      vehicleListItemAccepted.driver.image,
                                  driverNmae:
                                      vehicleListItemAccepted.driver.name,
                                  quantity: vehicleListItemAccepted.quantity,
                                  type: vehicleListItemAccepted.type,
                                  userImage: vehicleListItemAccepted.user.image,
                                  userNmae: vehicleListItemAccepted.user.name,
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );
                          case TabStatus.cancelled:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.rentHistoryPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<RentHistoryList>(
                                      noItemsFoundIndicatorBuilder: (context) {
                                return  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                      height: 110,
                                      isSVGImage: true,
                                      localImageAssetURL:
                                          AppAssetImages.carRentSVGLogoSolid,
                                      title: AppLanguageTranslation.haveNoRentTransKey.toCurrentLanguage,
                                    ),
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final RentHistoryList vehicleListItemAccepted =
                                    item;

                                return RentHistoryWidget(
                                  onSendTap: () {
                                    Get.toNamed(AppPageNames.chatScreen,
                                        arguments:
                                            vehicleListItemAccepted.user.id);
                                  },
                                  onTap: () async {
                                    await Get.toNamed(
                                        AppPageNames.historyRentDetails,
                                        arguments: vehicleListItemAccepted);
                                    controller.rentHistoryPagingController
                                        .refresh();
                                  },
                                  dateTime: vehicleListItemAccepted.date,
                                  driverImage:
                                      vehicleListItemAccepted.driver.image,
                                  driverNmae:
                                      vehicleListItemAccepted.driver.name,
                                  quantity: vehicleListItemAccepted.quantity,
                                  type: vehicleListItemAccepted.type,
                                  userImage: vehicleListItemAccepted.user.image,
                                  userNmae: vehicleListItemAccepted.user.name,
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );
                          case TabStatus.completed:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.rentHistoryPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<RentHistoryList>(
                                      noItemsFoundIndicatorBuilder: (context) {
                                return  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                      height: 110,
                                      isSVGImage: true,
                                      localImageAssetURL:
                                          AppAssetImages.carRentSVGLogoSolid,
                                      title: AppLanguageTranslation.haveNoRentTransKey.toCurrentLanguage,
                                    ),
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final RentHistoryList vehicleListItemAccepted =
                                    item;

                                return RentHistoryWidget(
                                  onSendTap: () {
                                    Get.toNamed(AppPageNames.chatScreen,
                                        arguments:
                                            vehicleListItemAccepted.user.id);
                                  },
                                  onTap: () async {
                                    await Get.toNamed(
                                        AppPageNames.historyRentDetails,
                                        arguments: vehicleListItemAccepted);
                                    controller.rentHistoryPagingController
                                        .refresh();
                                  },
                                  dateTime: vehicleListItemAccepted.date,
                                  driverImage:
                                      vehicleListItemAccepted.driver.image,
                                  driverNmae:
                                      vehicleListItemAccepted.driver.name,
                                  quantity: vehicleListItemAccepted.quantity,
                                  type: vehicleListItemAccepted.type,
                                  userImage: vehicleListItemAccepted.user.image,
                                  userNmae: vehicleListItemAccepted.user.name,
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );
                        }
                      })
                    ],
                  ),
                ),
              )),
            ));
  }
}
