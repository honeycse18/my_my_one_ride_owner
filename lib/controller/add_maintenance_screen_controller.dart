import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/maintenance_details_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_car_elements_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/product_quantity_based_price_ui.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class AddMaintenanceScreenController extends GetxController {
  (String, String)? selectedPerson;
  String maintenanceItemId = '';
  TextEditingController totalCost = TextEditingController();
  TextEditingController partsName = TextEditingController();
  TextEditingController partsQty = TextEditingController();
  RentCarElementsVehicle? selectedVehicle;
  List<MaintenanceQuantityBasedPriceUI> maintenanceQuantityBasedPriceUIs = [
    MaintenanceQuantityBasedPriceUI(
        partsName: TextEditingController(), partsQty: TextEditingController())
  ];

  List<(String, String)> listOfPerson = [
    ('owner', 'Owner'),
    ('driver', 'Driver')
  ];
  List<RentCarElementsVehicle> vehicleList = [];
  var selectedDate = DateTime.now().obs;
  void updateSelectedStartDate(DateTime newDate) {
    selectedDate.value = newDate;
    update();
  }

  Widget rentCarElementsVehicle(RentCarElementsVehicle vehicle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: CachedNetworkImageWidget(
                imageURL: vehicle.images.firstOrNull ?? ''),
          ),
          AppGaps.wGap5,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(vehicle.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                Text(vehicle.vehicleNumber),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> getCarElementsRide() async {
    RentCarElementsResponse? response = await APIRepo.getRideCarElements();
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseElementTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingElements(response);
  }

  onSuccessRetrievingElements(RentCarElementsResponse response) {
    vehicleList = response.data.vehicles;
    update();
  }

  Future<void> addMaintenance() async {
    final Map<String, dynamic> requestBody = {
      'vehicle': selectedVehicle?.id ?? '',
      'start_date': APIHelper.toServerDateTimeFormattedStringFromDateTime(
          selectedDate.value),
      'cost': int.tryParse(totalCost.text),
      'bearer': selectedPerson?.$1,
      'parts': maintenanceQuantityBasedPriceUIs
          .map((e) => <String, dynamic>{
                "name": e.partsName.text,
                'quantity': int.tryParse(e.partsQty.text)
              })
          .toList()
    };
    RawAPIResponse? response = await APIRepo.addMaintenance(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseMaintainTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessAddingVehicleToRide(response);
  }

  onSuccessAddingVehicleToRide(RawAPIResponse response) async {
    Get.back();
    await AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.addMaintainTransKey.toCurrentLanguage);
    return;
  }

  Future<void> updateMaintenance() async {
    final Map<String, dynamic> requestBody = {
      '_id': maintenanceItemId,
      'vehicle': selectedVehicle?.id ?? '',
      'start_date': APIHelper.toServerDateTimeFormattedStringFromDateTime(
          selectedDate.value),
      'cost': int.tryParse(totalCost.text),
      'bearer': selectedPerson?.$1,
      'parts': maintenanceQuantityBasedPriceUIs
          .map((e) => <String, dynamic>{
                "name": e.partsName.text,
                'quantity': int.tryParse(e.partsQty.text)
              })
          .toList()
    };
    RawAPIResponse? response = await APIRepo.updateMaintenance(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseMaintainTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessUpdatingVehicleToRide(response);
  }

  onSuccessUpdatingVehicleToRide(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  Future<void> getMaintenanceDetails() async {
    MaintenanceDetailsResponse? response =
        await APIRepo.getMaintenanceDetails(maintenanceItemId);
    if (response == null) {
      Helper.showSnackBar(
          AppLanguageTranslation.noResponseFuelTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingDetails(response);
  }

  onSuccessRetrievingDetails(MaintenanceDetailsResponse response) {
    MaintenanceDetailsData maintenanceDetailsData = response.data;
    final foundSelected = vehicleList.firstWhereOrNull(
        (element) => element.id == maintenanceDetailsData.vehicle.id);
    if (foundSelected != null) {
      selectedVehicle = foundSelected;
      update();
    }
    selectedDate.value = maintenanceDetailsData.date;
    totalCost.text = maintenanceDetailsData.cost.toString();
    final foundSelectedPerson = listOfPerson.firstWhereOrNull(
        (element) => element.$1 == maintenanceDetailsData.bearer);
    if (foundSelectedPerson != null) {
      selectedPerson = foundSelectedPerson;
      update();
    }
    maintenanceQuantityBasedPriceUIs = maintenanceDetailsData.parts.map((e) {
      TextEditingController nameController =
          TextEditingController(text: e.name);
      TextEditingController quantityController =
          TextEditingController(text: e.quantity.toString());
      return MaintenanceQuantityBasedPriceUI(
          partsName: nameController, partsQty: quantityController);
    }).toList();
    update();
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      maintenanceItemId = params;
      update();
      log('Fuel Item Id: $maintenanceItemId');
    }
  }

  @override
  void onInit() async {
    _getScreenParameters();

    await getCarElementsRide();
    if (maintenanceItemId.isNotEmpty) {
      getMaintenanceDetails();
    }

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    for (var a in maintenanceQuantityBasedPriceUIs) {
      a.partsName.dispose();
      a.partsQty.dispose();
    }
    super.onClose();
  }
}
