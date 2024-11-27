import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/vehicle_details_information_screen_controller.dart';
import 'package:one_ride_car_owner/models/enums.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/vehicle_features_item_widget.dart';
import 'package:one_ride_car_owner/widgets/vehicle_list_tab_screen_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class VehicleDetailsInformationScreen extends StatelessWidget {
  const VehicleDetailsInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VehicleDetailsInfoScreenController>(
        init: VehicleDetailsInfoScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget:
                      Text(controller.vehicleDetailsItem.vehicleNumber),
                  actions: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: 40,
                      width: 80,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: TextButton(
                          onPressed: controller.onEditButtonTap,
                          child: Text(
                            AppLanguageTranslation
                                .editTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodySmallMediumTextStyle
                                .copyWith(decoration: TextDecoration.underline),
                          )),
                    )
                  ]),
              body: ScaffoldBodyWidget(
                  child: CustomScrollView(slivers: [
                const SliverToBoxAdapter(child: AppGaps.hGap15),
                SliverToBoxAdapter(
                  child: Text(
                    controller.vehicleDetailsItem.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                  ),
                ),
                const SliverToBoxAdapter(child: AppGaps.hGap2),
                SliverToBoxAdapter(
                  child: Text(
                    controller.vehicleDetailsItem.category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeTextStyle
                        .copyWith(color: AppColors.bodyTextColor),
                  ),
                ),
                const SliverToBoxAdapter(child: AppGaps.hGap18),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 175,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Container(
                          height: 156,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.primaryBorderColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          child: Row(
                            children: [
                              Expanded(
                                child: PageView.builder(
                                  controller: controller.imageController,
                                  scrollDirection: Axis.horizontal,
                                  /* onPageChanged: (index) {
                                    controller.images =
                                        controller.vehicleDetailsItem.images;
                                    controller.update();
                                  }, */
                                  itemCount: controller
                                      .vehicleDetailsItem.images.length,
                                  itemBuilder: (context, index) {
                                    final images = controller
                                        .vehicleDetailsItem.images[index];
                                    return GestureDetector(
                                        child: CachedNetworkImageWidget(
                                          imageURL: images,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius: AppComponents
                                                    .imageBorderRadius,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fitWidth)),
                                          ),
                                        ),
                                        onTap: () => Get.toNamed(
                                            AppPageNames.imageZoomScreen,
                                            arguments: images));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: SmoothPageIndicator(
                            controller: controller.imageController,
                            count: controller.vehicleDetailsItem.images.isEmpty
                                ? 1
                                : controller.vehicleDetailsItem.images.length,
                            axisDirection: Axis.horizontal,
                            effect: const ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                spacing: 2,
                                expansionFactor: 3,
                                activeDotColor: AppColors.mainTextColor,
                                dotColor: AppColors.bodyTextColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: AppGaps.hGap32),
                SliverToBoxAdapter(
                    child: SizedBox(
                        height: 50,
                        child: Obx(() => Row(
                              children: [
                                Expanded(
                                    child: ListTabStatusWidget(
                                  text: VehicleDetailsInfoTypeStatus
                                      .specifications.stringValueForView,
                                  isSelected:
                                      controller.vehicleInfoStatusTab.value ==
                                          VehicleDetailsInfoTypeStatus
                                              .specifications,
                                  onTap: () {
                                    controller.onTabTap(
                                        VehicleDetailsInfoTypeStatus
                                            .specifications);
                                  },
                                )),
                                AppGaps.wGap10,
                                Expanded(
                                    child: ListTabStatusWidget(
                                  text: VehicleDetailsInfoTypeStatus
                                      .features.stringValueForView,
                                  isSelected:
                                      controller.vehicleInfoStatusTab.value ==
                                          VehicleDetailsInfoTypeStatus.features,
                                  onTap: () {
                                    controller.onTabTap(
                                        VehicleDetailsInfoTypeStatus.features);
                                  },
                                )),
                                AppGaps.wGap10,
                                Expanded(
                                    child: ListTabStatusWidget(
                                  text: VehicleDetailsInfoTypeStatus
                                      .documents.stringValueForView,
                                  isSelected: controller
                                          .vehicleInfoStatusTab.value ==
                                      VehicleDetailsInfoTypeStatus.documents,
                                  onTap: () {
                                    controller.onTabTap(
                                        VehicleDetailsInfoTypeStatus.documents);
                                  },
                                )),
                              ],
                            )))),
                const SliverToBoxAdapter(child: AppGaps.hGap24),
                Obx(() {
                  switch (controller.vehicleInfoStatusTab.value) {
                    case VehicleDetailsInfoTypeStatus.specifications:
                      return SliverToBoxAdapter(
                          child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssetImages.maxpowerPng,
                                    height: 19,
                                    color: AppColors.mainTextColor,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    AppLanguageTranslation
                                        .maxPowerTransKey.toCurrentLanguage,
                                    style:
                                        AppTextStyles.smallestMediumTextStyle,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    controller.vehicleDetailsItem.maxPower,
                                    style:
                                        AppTextStyles.smallestMediumTextStyle,
                                  ),
                                ],
                              )),
                            ),
                          ),
                          AppGaps.wGap16,
                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssetImages.maxSpeedPng,
                                    height: 19,
                                    color: AppColors.mainTextColor,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    AppLanguageTranslation
                                        .maxSpeedTransKey.toCurrentLanguage,
                                    style:
                                        AppTextStyles.smallestMediumTextStyle,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    controller.vehicleDetailsItem.maxSpeed,
                                    style:
                                        AppTextStyles.smallestMediumTextStyle,
                                  ),
                                ],
                              )),
                            ),
                          ),
                          AppGaps.wGap16,
                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssetImages.mileagePng,
                                    height: 19,
                                    color: AppColors.mainTextColor,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    AppLanguageTranslation
                                        .mileageTransKey.toCurrentLanguage,
                                    style:
                                        AppTextStyles.smallestMediumTextStyle,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    '${controller.vehicleDetailsItem.maxPower} hp',
                                    style:
                                        AppTextStyles.smallestMediumTextStyle,
                                  ),
                                ],
                              )),
                            ),
                          ),
                          AppGaps.wGap16,
                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssetImages.seatPng,
                                    height: 19,
                                    color: AppColors.mainTextColor,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    AppLanguageTranslation
                                        .seatTransKey.toCurrentLanguage,
                                    style:
                                        AppTextStyles.smallestMediumTextStyle,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    '${controller.vehicleDetailsItem.capacity} ${AppLanguageTranslation.seatTransKey.toCurrentLanguage}',
                                    style:
                                        AppTextStyles.smallestMediumTextStyle,
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ],
                      ));
                    case VehicleDetailsInfoTypeStatus.features:
                      return SliverToBoxAdapter(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLanguageTranslation
                                .carFeatureTransKey.toCurrentLanguage,
                            style:
                                AppTextStyles.titleSemiSmallSemiboldTextStyle,
                          ),
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .modelTransKey.toCurrentLanguage,
                            featuresValue: controller.vehicleDetailsItem.model,
                          ),
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .modelYearTransKey.toCurrentLanguage,
                            featuresValue: controller.vehicleDetailsItem.year,
                          ),
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .vehicleColorTransKey.toCurrentLanguage,
                            featuresValue: controller.vehicleDetailsItem.color,
                          ),
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .fuelTypeTransKey.toCurrentLanguage,
                            featuresValue:
                                controller.vehicleDetailsItem.fuelType,
                          ),
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .gearTypeTransKey.toCurrentLanguage,
                            featuresValue:
                                controller.vehicleDetailsItem.gearType,
                          ),
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: 'AC',
                            featuresValue: controller.vehicleDetailsItem.ac
                                ? AppLanguageTranslation
                                    .yesAllowedTransKey.toCurrentLanguage
                                : AppLanguageTranslation
                                    .noAllowedTransKey.toCurrentLanguage,
                          ),
                          AppGaps.hGap16,
                          AppGaps.hGap16,
                        ],
                      ));
                    case VehicleDetailsInfoTypeStatus.documents:
                      return SliverToBoxAdapter(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .numberPlateTransKey.toCurrentLanguage,
                            featuresValue:
                                controller.vehicleDetailsItem.vehicleNumber,
                          ),
                          AppGaps.hGap24,
                          Text(
                            AppLanguageTranslation
                                .vehicleRegDocumentTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodyLargeMediumTextStyle,
                          ),
                          AppGaps.hGap16,
                          SizedBox(
                            height: 220,
                            child: Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                Container(
                                  height: 196,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primaryBorderColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(18))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: PageView.builder(
                                          controller:
                                              controller.documentController,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: controller
                                              .vehicleDetailsItem
                                              .documents
                                              .length,
                                          itemBuilder: (context, index) {
                                            final documents = controller
                                                .vehicleDetailsItem
                                                .documents[index];
                                            return GestureDetector(
                                              child: CachedNetworkImageWidget(
                                                imageURL: documents,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius: AppComponents
                                                          .imageBorderRadius,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit:
                                                              BoxFit.fitWidth)),
                                                ),
                                              ),
                                              onTap: () => Get.toNamed(
                                                  AppPageNames.imageZoomScreen,
                                                  arguments: documents),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: SmoothPageIndicator(
                                    controller: controller.documentController,
                                    count: controller.vehicleDetailsItem
                                            .documents.isEmpty
                                        ? 1
                                        : controller.vehicleDetailsItem
                                            .documents.length,
                                    axisDirection: Axis.horizontal,
                                    effect: ExpandingDotsEffect(
                                        dotHeight: 12,
                                        dotWidth: 6,
                                        spacing: 2,
                                        expansionFactor: 3,
                                        activeDotColor: AppColors.mainTextColor
                                            .withOpacity(0.5),
                                        dotColor: AppColors.bodyTextColor
                                            .withOpacity(0.3)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ));
                  }
                })
              ])),
            ));
  }
}
