import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:one_ride_car_owner/controller/add_maintenance_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_car_elements_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/product_quantity_based_price_ui.dart';

class AddMaintenanceScreen extends StatelessWidget {
  const AddMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMaintenanceScreenController>(
        init: AddMaintenanceScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(controller.maintenanceItemId.isEmpty
                      ? AppLanguageTranslation
                          .addMaintainSTransKey.toCurrentLanguage
                      : AppLanguageTranslation
                          .updateMaintainSTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: SingleChildScrollView(
                child: Column(children: [
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
                  AppGaps.hGap24,
                  CustomTextFormField(
                    labelText: AppLanguageTranslation
                        .maintainSDateTransKey.toCurrentLanguage,
                    hintText: '24 oct, 2024',
                    isReadOnly: true,
                    controller: TextEditingController(
                      text:
                          '${DateFormat('yyyy-MM-dd').format(controller.selectedDate.value)}      ',
                    ),
                    prefixIcon: const SvgPictureAssetWidget(
                        AppAssetImages.calenderSVGLogoLine),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 100),
                      );
                      if (pickedDate != null) {
                        controller.updateSelectedStartDate(pickedDate);
                      }

                      controller.update();
                    },
                  ),
                  AppGaps.hGap24,
                  CustomTextFormField(
                    textInputType: TextInputType.number,
                    controller: controller.totalCost,
                    labelText: AppLanguageTranslation
                        .totalCostTransKey.toCurrentLanguage,
                    hintText: 'Eg : 50',
                  ),
                  AppGaps.hGap24,
                  DropdownButtonFormFieldWidget(
                    hintText:
                        AppLanguageTranslation.selectTransKey.toCurrentLanguage,
                    labelText: AppLanguageTranslation
                        .costBearTransKey.toCurrentLanguage,
                    value: controller.selectedPerson,
                    items: controller.listOfPerson,
                    isDense: false,
                    getItemText: (p0) => p0.$2,
                    // getItemChild: controller.rentCarElementsVehicle,
                    onChanged: (selectedItem) {
                      controller.selectedPerson = selectedItem;
                      controller.update();
                    },
                  ),
                  /* AppGaps.hGap24,
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          textInputType: TextInputType.number,
                          controller: controller.partsName,
                          labelText: 'Parts Name',
                          hintText: 'Eg : plug',
                        ),
                      ),
                      AppGaps.wGap10,
                      Expanded(
                        child: CustomTextFormField(
                          textInputType: TextInputType.number,
                          controller: controller.partsQty,
                          labelText: 'Parts Qty ',
                          hintText: 'eg: 1',
                        ),
                      ),
                    ],
                  ), */
                  AppGaps.hGap24,
                  ...controller.maintenanceQuantityBasedPriceUIs.mapIndexed((i,
                          productQuantityBasedPriceUI) =>
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    textInputType: TextInputType.number,
                                    controller:
                                        productQuantityBasedPriceUI.partsName,
                                    labelText: AppLanguageTranslation
                                        .partsNameTransKey.toCurrentLanguage,
                                    hintText: 'Eg : plug',
                                  ),
                                ),
                                AppGaps.wGap10,
                                Expanded(
                                  child: CustomTextFormField(
                                    textInputType: TextInputType.number,
                                    controller:
                                        productQuantityBasedPriceUI.partsQty,
                                    labelText: AppLanguageTranslation
                                        .partsQtyTransKey.toCurrentLanguage,
                                    hintText: 'eg: 1',
                                  ),
                                ),
                              ],
                            ),
                            if (i != 0) AppGaps.hGap12,
                            if (i != 0)
                              TightTextIconButtonWidget(
                                  text: AppLanguageTranslation
                                      .deleteTransKey.toCurrentLanguage,
                                  iconWidget: const SvgPictureAssetWidget(
                                    AppAssetImages.deletSVGLogoLine,
                                    color: AppColors.alertColor,
                                  ),
                                  textStyle: const TextStyle(
                                      color: AppColors.alertColor),
                                  onTap: () {
                                    controller.maintenanceQuantityBasedPriceUIs
                                        .remove(productQuantityBasedPriceUI);
                                    controller.update();
                                  }),
                            AppGaps.hGap24,
                          ])),
                  AppGaps.hGap24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RawButtonWidget(
                        child: Container(
                          height: 36,
                          width: 92,
                          decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Center(
                            child: Text(
                              '+ ${AppLanguageTranslation.addMoreTransKey.toCurrentLanguage}',
                              style: AppTextStyles.bodySmallTextStyle
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () {
                          controller.maintenanceQuantityBasedPriceUIs.add(
                              MaintenanceQuantityBasedPriceUI(
                                  partsName: TextEditingController(),
                                  partsQty: TextEditingController()));
                          controller.update();
                        },
                      )
                    ],
                  ),
                  AppGaps.hGap24,
                  CustomStretchedButtonWidget(
                    onTap: controller.maintenanceItemId.isEmpty
                        ? controller.addMaintenance
                        : controller.updateMaintenance,
                    child: Text(controller.maintenanceItemId.isEmpty
                        ? AppLanguageTranslation
                            .addMaintainSTransKey.toCurrentLanguage
                        : AppLanguageTranslation
                            .updateMaintainSTransKey.toCurrentLanguage),
                  ),
                  AppGaps.hGap24,
                ]),
              )),
            ));
  }
}
