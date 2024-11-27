import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/vehicle_details_screen_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/settings_screen_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VehicleDetailsScreenController>(
        init: VehicleDetailsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(
                    controller.vehicleDetailsItem.vehicleNumber,
                  )),
              body: ScaffoldBodyWidget(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap15,
                    Text(
                      controller.vehicleDetailsItem.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                    ),
                    AppGaps.hGap2,
                    Text(
                      controller.vehicleDetailsItem.category.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLargeTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                    AppGaps.hGap18,
                    SizedBox(
                      height: 250,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            height: 236,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryBorderColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
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
                              count: controller
                                      .vehicleDetailsItem.images.isEmpty
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
                    AppGaps.hGap32,
                    Text(
                      AppLanguageTranslation
                          .informationTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiSmallMediumTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                    AppGaps.hGap16,
                    OptionListTileWidget(
                      titleText: AppLanguageTranslation
                          .vehicleInforTransKey.toCurrentLanguage,
                      onTap: () {
                        Get.toNamed(
                            AppPageNames.vehicleDetailsInformationScreen,
                            arguments: controller.vehicleDetailsItem);
                      },
                    ),
                    AppGaps.hGap24,
                    /* Text(
                      'Performance',
                      style: AppTextStyles.titleSemiSmallMediumTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                    AppGaps.hGap16,
                    OptionListTileWidget(
                      titleText: 'Vehicle Perfomance',
                      onTap: () {},
                    ),
                    AppGaps.hGap24, */
                    Text(
                      AppLanguageTranslation.actionTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiSmallMediumTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                    AppGaps.hGap16,
                    OptionListTileWidget(
                      showRightArrow: false,
                      titleText: AppLanguageTranslation
                          .removeVehicleTransKey.toCurrentLanguage,
                      onTap: controller.onRemoveVehicleTap,
                    ),
                  ],
                ),
              )),
            ));
  }
}
