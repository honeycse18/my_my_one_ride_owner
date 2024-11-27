import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:one_ride_car_owner/controller/add_fuel_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_car_elements_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class AddFuelScreen extends StatelessWidget {
  const AddFuelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddFuelScreenController>(
        init: AddFuelScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(
                      AppLanguageTranslation.addFuTransKey.toCurrentLanguage)),
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
                        .fillDateTransKey.toCurrentLanguage,
                    hintText: AppLanguageTranslation
                        .startDateTransKey.toCurrentLanguage,
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
                    controller: controller.quantityFuel,
                    labelText: AppLanguageTranslation
                        .quantityTransKey.toCurrentLanguage,
                    hintText: 'Eg : 10',
                  ),
                  AppGaps.hGap24,
                  CustomTextFormField(
                    textInputType: TextInputType.number,
                    controller: controller.fuelCost,
                    labelText: AppLanguageTranslation
                        .fuelCostTransKey.toCurrentLanguage,
                    hintText: 'Eg : 50',
                  ),
                  AppGaps.hGap24,
                  DropdownButtonFormFieldWidget(
                    hintText:
                        AppLanguageTranslation.addTransKey.toCurrentLanguage,
                    labelText: AppLanguageTranslation
                        .fuelCostBearTransKey.toCurrentLanguage,
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
                  AppGaps.hGap24,
                  CustomTextFormField(
                    textInputType: TextInputType.number,
                    controller: controller.startedMeter,
                    labelText: AppLanguageTranslation
                        .startedMeterTransKey.toCurrentLanguage,
                    hintText: 'Eg : 2050',
                  ),
                  AppGaps.hGap24,
                  CustomTextFormField(
                    controller: controller.note,
                    labelText:
                        AppLanguageTranslation.noteTransKey.toCurrentLanguage,
                    hintText:
                        AppLanguageTranslation.noteTransKey.toCurrentLanguage,
                  ),
                  AppGaps.hGap24,
                  CustomStretchedButtonWidget(
                    onTap: controller.fuelItemId.isEmpty
                        ? controller.addFuel
                        : controller.updateFuel,
                    child: Text(controller.fuelItemId.isEmpty
                        ? AppLanguageTranslation.addFuTransKey.toCurrentLanguage
                        : AppLanguageTranslation
                            .updateFuelTransKey.toCurrentLanguage),
                  ),
                  AppGaps.hGap24,
                ]),
              )),
            ));
  }
}
