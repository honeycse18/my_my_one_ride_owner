import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/maintanance_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/maintanance_list_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/maintenance_management_list_widget.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MaintenanceScreenController>(
        init: MaintenanceScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .maintenanceManagementTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: RefreshIndicator(
                onRefresh: () async =>
                    controller.maintenanceListPagingController.refresh(),
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(child: AppGaps.hGap10),
                    SliverToBoxAdapter(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.8),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18))),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: 58,
                                    child: Obx(() =>
                                        CustomTabToggleButtonWidget(
                                            text: AppLanguageTranslation
                                                .activeTransKey
                                                .toCurrentLanguage,
                                            isSelected: !controller
                                                .isActiveSelected.value,
                                            onTap: () {
                                              controller.isActiveSelected
                                                  .value = false;
                                              controller
                                                  .maintenanceListPagingController
                                                  .refresh();
                                            })),
                                  ),
                                ),
                              ),
                              AppGaps.wGap5,
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: 58,
                                    child: Obx(() =>
                                        CustomTabToggleButtonWidget(
                                            text: AppLanguageTranslation
                                                .completeTransKey
                                                .toCurrentLanguage,
                                            isSelected: controller
                                                .isActiveSelected.value,
                                            onTap: () {
                                              controller.isActiveSelected
                                                  .value = true;
                                              controller
                                                  .maintenanceListPagingController
                                                  .refresh();
                                            })),
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
                    const SliverToBoxAdapter(child: AppGaps.hGap10),
                    Obx(() => !controller.isActiveSelected.value
                        ? PagedSliverList.separated(
                            pagingController:
                                controller.maintenanceListPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<MaintenanceListItem>(
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
                                            .noMaintenanceRecordTransKey
                                            .toCurrentLanguage),
                                  ],
                                );
                              },
                              itemBuilder: (context, item, index) {
                                final MaintenanceListItem addedMaintenenceList =
                                    item;
                                return MaintenanceManagementListWidget(
                                  parts: addedMaintenenceList.parts
                                      .map((e) => e.name)
                                      .toList(),
                                  onSelected: (value) =>
                                      controller.onSelectedTap(
                                          addedMaintenenceList.id, value),
                                  status: addedMaintenenceList.status,
                                  carCategoryName: addedMaintenenceList
                                      .vehicle.category.name,
                                  carCostBear: addedMaintenenceList.bearer,
                                  carImage: Helper.getFirstSafeString(
                                      addedMaintenenceList.vehicle.images),
                                  carName: addedMaintenenceList.vehicle.name,
                                  cost: addedMaintenenceList.cost,
                                  date: addedMaintenenceList.date,
                                );
                              },
                            ),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap24,
                          )
                        : PagedSliverList.separated(
                            pagingController:
                                controller.maintenanceListPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<MaintenanceListItem>(
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
                                final MaintenanceListItem addedMaintenenceList =
                                    item;
                                return MaintenanceManagementListWidget(
                                  parts: addedMaintenenceList.parts
                                      .map((e) => e.name)
                                      .toList(),
                                  onSelected: (value) =>
                                      controller.onSelectedTap(
                                          addedMaintenenceList.id, value),
                                  status: addedMaintenenceList.status,
                                  carCategoryName: addedMaintenenceList
                                      .vehicle.category.name,
                                  carCostBear: addedMaintenenceList.bearer,
                                  carImage: Helper.getFirstSafeString(
                                      addedMaintenenceList.vehicle.images),
                                  carName: addedMaintenenceList.vehicle.name,
                                  cost: addedMaintenenceList.cost,
                                  date: addedMaintenenceList.date,
                                );
                              },
                            ),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap24,
                          )),
                    const SliverToBoxAdapter(child: AppGaps.hGap80),
                  ],
                ),
              )),
              floatingActionButton: FloatingActionButton.extended(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14.0))),
                onPressed: () async {
                  await Get.toNamed(AppPageNames.addMaintenenceScreen);
                  controller.maintenanceListPagingController.refresh();
                },
                label: Text(
                    AppLanguageTranslation
                        .addMaintainSTransKey.toCurrentLanguage,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle
                        .copyWith(color: Colors.white)),
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ));
  }
}
