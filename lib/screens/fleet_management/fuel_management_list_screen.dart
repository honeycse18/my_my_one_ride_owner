import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/fuel_management_list_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/fuel_list_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/fuel_management_list_widget.dart';

class FuelManagementListScreen extends StatelessWidget {
  const FuelManagementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FuelManagementScreenController>(
        init: FuelManagementScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .fuelManagementTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: RefreshIndicator(
                onRefresh: () async =>
                    controller.fuelListPagingController.refresh(),
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
                                                  .fuelListPagingController
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
                                                  .fuelListPagingController
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
                                controller.fuelListPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<FuelCarListItem>(
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
                                            .youHaveNoFuelTransKey
                                            .toCurrentLanguage),
                                  ],
                                );
                              },
                              itemBuilder: (context, item, index) {
                                final FuelCarListItem addedFuelList = item;
                                return FuelManagementListWidget(
                                  onSelected: (value) => controller
                                      .onSelectedTap(addedFuelList.id, value),
                                  endDate: addedFuelList.endDate,
                                  status: addedFuelList.status,
                                  quantity: addedFuelList.quantity,
                                  carCategoryName:
                                      addedFuelList.vehicle.category.name,
                                  carCostBear: addedFuelList.bearer,
                                  carImage: Helper.getFirstSafeString(
                                      addedFuelList.vehicle.images),
                                  carName: addedFuelList.vehicle.name,
                                  cost: addedFuelList.cost,
                                  fillDate: addedFuelList.startDate,
                                  startKm: addedFuelList.startKm,
                                );
                              },
                            ),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap24,
                          )
                        : PagedSliverList.separated(
                            pagingController:
                                controller.fuelListPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<FuelCarListItem>(
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
                                            .youHaveNoFuelTransKey
                                            .toCurrentLanguage),
                                  ],
                                );
                              },
                              itemBuilder: (context, item, index) {
                                final FuelCarListItem addedDriverList = item;
                                return FuelManagementListWidget(
                                  onSelected: (value) => controller
                                      .onSelectedTap(addedDriverList.id, value),
                                  status: addedDriverList.status,
                                  endDate: addedDriverList.endDate,
                                  quantity: addedDriverList.quantity,
                                  carCategoryName:
                                      addedDriverList.vehicle.category.name,
                                  carCostBear: addedDriverList.bearer,
                                  carImage: Helper.getFirstSafeString(
                                      addedDriverList.vehicle.images),
                                  carName: addedDriverList.vehicle.name,
                                  cost: addedDriverList.cost,
                                  fillDate: addedDriverList.startDate,
                                  startKm: addedDriverList.startKm,
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
                  await Get.toNamed(AppPageNames.addFuelScreen);
                  controller.fuelListPagingController.refresh();
                },
                label: Text(
                    AppLanguageTranslation.addFuTransKey.toCurrentLanguage,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle
                        .copyWith(color: Colors.white)),
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ));
  }
}
