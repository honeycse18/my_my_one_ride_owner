import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/add_rent_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_car_elements_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class AddRentScreen extends StatelessWidget {
  const AddRentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRentScreenController>(
        init: AddRentScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(controller.rentId.isEmpty
                      ? AppLanguageTranslation.addRentTransKey.toCurrentLanguage
                      : AppLanguageTranslation
                          .updateRentTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap20,
                    DropdownButtonFormFieldWidget(
                      hintText: AppLanguageTranslation
                          .yourVehicleTransKey.toCurrentLanguage,
                      labelText: AppLanguageTranslation
                          .selectVehicleTransKey.toCurrentLanguage,
                      value: controller.selectedVehicle,
                      items: controller.vehicleList,
                      isDense: false,
                      // getItemText: (p0) => p0.name,
                      getItemChild: controller.rentCarElementsVehicle,
                      onChanged: (selectedItem) {
                        controller.selectedVehicle =
                            selectedItem ?? RentCarElementsVehicle();
                        controller.update();
                      },
                    ),
                    AppGaps.hGap16,
                    DropdownButtonFormFieldWidget(
                      hintText: AppLanguageTranslation
                          .driverIncludedTransKey.toCurrentLanguage,
                      labelText: AppLanguageTranslation
                          .driverIncludedTransKey.toCurrentLanguage,
                      value: controller.driverIncluded ? 'Yes' : 'No',
                      items: const ['Yes', 'No'],
                      getItemText: (p0) => p0,
                      onChanged: (selectedItem) {
                        controller.driverIncluded =
                            selectedItem == 'Yes' ? true : false;
                        controller.update();
                      },
                    ),
                    AppGaps.hGap16,
                    if (controller.driverIncluded)
                      DropdownButtonFormFieldWidget(
                        hintText: AppLanguageTranslation
                            .assignYourDriverTransKey.toCurrentLanguage,
                        labelText: AppLanguageTranslation
                            .assignYourDriverTransKey.toCurrentLanguage,
                        value: controller.selectedDriver,
                        items: controller.driverList,
                        isDense: false,
                        // getItemText: (p0) => p0.name,
                        getItemChild: controller.rentCarElementsDriver,
                        onChanged: (selectedItem) {
                          controller.selectedDriver =
                              selectedItem ?? RentCarElementsDriver();
                          controller.update();
                        },
                      ),
                    if (controller.driverIncluded) AppGaps.hGap16,
                    Row(
                      children: [
                        Text(
                            AppLanguageTranslation
                                .setPriceTransKey.toCurrentLanguage,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            )),
                        AppGaps.wGap15,
                        GestureDetector(
                            onTap: () {
                              AppDialogs.showSuccessDialog(
                                  titleText: AppLanguageTranslation
                                      .informationTransKey.toCurrentLanguage,
                                  messageText: AppLanguageTranslation
                                      .setYourPriceTransKey.toCurrentLanguage);
                            },
                            child: const SvgPictureAssetWidget(
                                AppAssetImages.infoSVGIcon))
                      ],
                    ),
                    AppGaps.hGap16,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      controller.hourlyChecked =
                                          controller.onCheckBoxUpdate(
                                              controller
                                                  .hourlyCarRentTextEditingController,
                                              controller.hourlyChecked);
                                      controller.update();
                                    },
                                    child: Text(AppLanguageTranslation
                                        .hourlyTransKey.toCurrentLanguage)),
                                Checkbox(
                                    /*  side: const BorderSide(
                                        width: 2,
                                        color: AppColors.mainTextColor), */
                                    value: controller.hourlyChecked,
                                    onChanged: ((value) {
                                      controller.hourlyChecked = value ?? false;
                                      controller.onCheckBoxUpdate(
                                          controller
                                              .hourlyCarRentTextEditingController,
                                          controller.hourlyChecked,
                                          value: value);
                                      controller.update();
                                    }))
                              ],
                            ),
                            CustomTextFormField(
                              controller:
                                  controller.hourlyCarRentTextEditingController,
                              isReadOnly: !controller.hourlyChecked,
                              hintText: '\$40',
                            )
                          ],
                        )),
                        AppGaps.wGap8,
                        Expanded(
                            child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      controller.weeklyChecked =
                                          controller.onCheckBoxUpdate(
                                              controller
                                                  .weeklyCarRentTextEditingController,
                                              controller.weeklyChecked);
                                      controller.update();
                                    },
                                    child: Text(AppLanguageTranslation
                                        .weeklyTransKey.toCurrentLanguage)),
                                Checkbox(
                                    /* side: BorderSide(
                                        width: 2,
                                        color: AppColors.mainTextColor), */
                                    value: controller.weeklyChecked,
                                    onChanged: ((value) {
                                      controller.weeklyChecked = value ?? false;
                                      controller.onCheckBoxUpdate(
                                          controller
                                              .weeklyCarRentTextEditingController,
                                          controller.weeklyChecked,
                                          value: value);
                                      controller.update();
                                    }))
                              ],
                            ),
                            CustomTextFormField(
                              controller:
                                  controller.weeklyCarRentTextEditingController,
                              isReadOnly: !controller.weeklyChecked,
                              hintText: '\$40',
                            )
                          ],
                        )),
                        AppGaps.wGap8,
                        Expanded(
                            child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      controller.monthlyChecked =
                                          controller.onCheckBoxUpdate(
                                              controller
                                                  .monthlyCarRentTextEditingController,
                                              controller.monthlyChecked);
                                      controller.update();
                                    },
                                    child: Text(AppLanguageTranslation
                                        .monthlyTransKey.toCurrentLanguage)),
                                Checkbox(
                                    /* side: BorderSide(
                                        width: 2,
                                        color: AppColors.mainTextColor), */
                                    value: controller.monthlyChecked,
                                    onChanged: ((value) {
                                      controller.monthlyChecked =
                                          value ?? false;
                                      controller.onCheckBoxUpdate(
                                          controller
                                              .monthlyCarRentTextEditingController,
                                          controller.monthlyChecked,
                                          value: value);
                                      controller.update();
                                    }))
                              ],
                            ),
                            CustomTextFormField(
                              controller: controller
                                  .monthlyCarRentTextEditingController,
                              isReadOnly: !controller.monthlyChecked,
                              hintText: '\$40',
                            )
                          ],
                        )),
                      ],
                    ),
                    AppGaps.hGap16,
                    CustomTextFormField(
                      isReadOnly: true,
                      onTap: controller.onLocationTap,
                      controller: controller.vehicleLocationTextController,
                      labelText: AppLanguageTranslation
                          .vehicleLocTransKey.toCurrentLanguage,
                      hintText: AppLanguageTranslation
                          .enterVehicleLocTransKey.toCurrentLanguage,
                    ),
                    AppGaps.hGap16,
                    Text(
                        AppLanguageTranslation
                            .facilitiesTransKey.toCurrentLanguage,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                    AppGaps.hGap16,
                    DropdownButtonFormFieldWidget(
                      hintText: 'No',
                      labelText: AppLanguageTranslation
                          .smokingAllowedTransKey.toCurrentLanguage,
                      items: [
                        AppLanguageTranslation
                            .yesAllowedTransKey.toCurrentLanguage,
                        AppLanguageTranslation
                            .noAllowedTransKey.toCurrentLanguage
                      ],
                      getItemText: (p0) => p0,
                      onChanged: (selectedItem) {
                        controller.smokingAllowed =
                            selectedItem == 'Yes' ? true : false;
                        controller.update();
                      },
                    ),
                    AppGaps.hGap16,
                    CustomTextFormField(
                      controller: controller.luggageSpaceTextController,
                      textInputType: TextInputType.number,
                      labelText: AppLanguageTranslation
                          .luggageSpaceTransKey.toCurrentLanguage,
                      hintText: 'e.g.: 4',
                    ),
                    AppGaps.hGap30,
                    StretchedTextButtonWidget(
                        onTap: controller.onAddVehicleButtonTap,
                        // backgroundColor: AppColors.primaryColor,
                        buttonText: controller.rentId.isEmpty
                            ? AppLanguageTranslation
                                .addVehiclesTransKey.toCurrentLanguage
                            : AppLanguageTranslation
                                .updateVehicleTransKey.toCurrentLanguage),
                    AppGaps.hGap10,
                  ],
                ),
              )),
            ));
  }
}
