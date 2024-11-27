import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/home_navigator/add_hire_driver_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/nearest_driver_response.dart';
import 'package:one_ride_car_owner/screens/bottom_sheet/hire_driver_bottomsheet.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/add_hire_driver_widgets.dart';

class AddHireDriverScreen extends StatelessWidget {
  const AddHireDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddHireDriverScreenControllerScreenController>(
        init: AddHireDriverScreenControllerScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .hireDriverTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: RefreshIndicator(
                onRefresh: () async =>
                    controller.nearestDriverPagingController.refresh(),
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap15,
                    ),
                    SliverToBoxAdapter(
                      child: SearchFilterRowWidget(
                          showFilter: false,
                          onSearchTap: () {
                            // Get.toNamed(AppPageNames.courseSubjectsScreen);
                          },
                          hintText: AppLanguageTranslation
                              .searchNameTransKey.toCurrentLanguage),
                    ),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap15,
                    ),
                    PagedSliverList.separated(
                      pagingController:
                          controller.nearestDriverPagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<NearestDriverList>(
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
                                      .noDriverAddTransKey.toCurrentLanguage),
                            ],
                          );
                        },
                        itemBuilder: (context, item, index) {
                          final NearestDriverList nearestDriverList = item;
                          return AddHireDriverListItemWidget(
                            onhireTap: () {
                              Get.bottomSheet(HireDriverBottomSheet(),
                                  settings: RouteSettings(
                                      arguments: nearestDriverList),
                                  isScrollControlled: true,
                                  ignoreSafeArea: false);
                            },
                            driverExperience: 0,
                            driverImage: nearestDriverList.image,
                            driverName: nearestDriverList.name,
                            driverRides: 0,
                            location: nearestDriverList.address,
                            rate: nearestDriverList.rate,
                            rating: 0,
                            onTap: () {
                              Get.toNamed(AppPageNames.hireDriverDetailsScreen,
                                  arguments: nearestDriverList);
                            },
                          );
                        },
                      ),
                      separatorBuilder: (context, index) => AppGaps.hGap24,
                    ),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap26,
                    ),
                  ],
                ),
              )),
            ));
  }
}
