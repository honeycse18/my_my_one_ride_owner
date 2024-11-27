import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/bottom_sheet_controller/add_driver_bottom_sheet_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/get_driver_list_widget.dart';

class AddDriverBottomSheet extends StatelessWidget {
  const AddDriverBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDriverBottomSheetScreenController>(
        init: AddDriverBottomSheetScreenController(),
        global: false,
        builder: (controller) => SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                /* controller.focusSearchDriver.hasFocus
                    ? MediaQuery.of(context).size.height * 0.7
                    : MediaQuery.of(context).size.height * 0.4, */
                padding: const EdgeInsets.only(top: 30, left: 12, right: 12),
                decoration: const BoxDecoration(
                    color: AppColors.mainBg,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Container(
                      height: 2,
                      width: 35,
                      color: AppColors.mainTextColor,
                    ),
                    AppGaps.hGap20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RawButtonWidget(
                          borderRadiusValue: 14,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                color: AppColors.appBarIconTextColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            child: const Center(
                              child: SvgPictureAssetWidget(
                                AppAssetImages.arrowLeftSVGLogoLine,
                                color: AppColors.mainTextColor,
                                height: 18,
                                width: 18,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.back();
                          },
                        ),
                        Text(
                          AppLanguageTranslation
                              .addDriverTransKey.toCurrentLanguage,
                          style: AppTextStyles.titleBoldTextStyle,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          height: 40,
                          width: 40,
                          /* decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))), */
                          /* child: TextButton(
                              onPressed: () {
                                Get.toNamed(AppPageNames.hireDriverScreen);
                              },
                              child: Text(
                                'Hire a Driver',
                                style: AppTextStyles.bodySmallMediumTextStyle
                                    .copyWith(
                                        decoration: TextDecoration.underline),
                              )), */
                        ),
                      ],
                    ),
                    AppGaps.hGap10,
                    CustomTextFormField(
                      focusNode: controller.focusSearchDriver,
                      onChanged: controller.onSearchChanges,
                      controller: controller.searchDriver,
                      labelText: AppLanguageTranslation
                          .searchDriverTransKey.toCurrentLanguage,
                      hintText: 'Eg.784696',
                      prefixIcon: const SvgPictureAssetWidget(
                          AppAssetImages.searchSVGLogoLine),
                    ),
                    AppGaps.hGap10,
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            final driverListItem =
                                controller.getDriverItem[index];
                            return GetSearchDriverListItemWidget(
                              driverImage: driverListItem.image,
                              driverName: driverListItem.name,
                              driverUid: driverListItem.uid,
                              onAddTap: () =>
                                  controller.addDriver(driverListItem.id),
                              onTap: () {
                                controller.addDriver(driverListItem.id);
                              },
                            );
                          },
                          separatorBuilder: (context, index) => AppGaps.hGap24,
                          itemCount: controller.getDriverItem.length),
                    )
                    /*  controller.focusSearchDriver.hasFocus
                        ? Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  final driverListItem =
                                      controller.getDriverItem[index];
                                  return GetSearchDriverListItemWidget(
                                    driverImage: driverListItem.image,
                                    driverName: driverListItem.name,
                                    driverUid: driverListItem.uid,
                                    onAddTap: () =>
                                        controller.addDriver(driverListItem.id),
                                    onTap: () {},
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap24,
                                itemCount: controller.getDriverItem.length),
                          )
                        : AppGaps.emptyGap, */
                  ],
                ),
              ),
            ));
  }
}
