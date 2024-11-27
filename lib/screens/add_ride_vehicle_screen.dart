import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/add_ride_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_car_elements_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class AddRideScreen extends StatelessWidget {
  const AddRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRideScreenController>(
        init: AddRideScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .addRideTransKey.toCurrentLanguage)),
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
                          .assignYourDriverTransKey.toCurrentLanguage,
                      labelText: AppLanguageTranslation
                          .assignYourDriverTransKey.toCurrentLanguage,
                      items: controller.driverList,
                      value: controller.selectedDriver,
                      isDense: false,
                      // getItemText: (p0) => p0.name,
                      getItemChild: controller.rentCarElementsDriver,
                      onChanged: (selectedItem) {
                        controller.selectedDriver =
                            selectedItem ?? RentCarElementsDriver();
                        controller.update();
                      },
                    ),
                    AppGaps.hGap30,
                    StretchedTextButtonWidget(
                        onTap: controller.onAddVehicleButtonTap,
                        // backgroundColor: AppColors.primaryColor,
                        buttonText: controller.rideId.isEmpty
                            ? AppLanguageTranslation
                                .addVehiclesTransKey.toCurrentLanguage
                            : AppLanguageTranslation
                                .updateVehiclesTransKey.toCurrentLanguage),
                    AppGaps.hGap10,
                  ],
                ),
              )),
            ));
  }
}
