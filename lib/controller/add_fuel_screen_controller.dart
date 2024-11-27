import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/fuel_details_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_car_elements_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class AddFuelScreenController extends GetxController {
  (String, String)? selectedPerson;
  String fuelItemId = '';
  TextEditingController quantityFuel = TextEditingController();
  TextEditingController fuelCost = TextEditingController();
  TextEditingController startedMeter = TextEditingController();
  TextEditingController note = TextEditingController();
  RentCarElementsVehicle? selectedVehicle;
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

  Future<void> addFuel() async {
    final Map<String, dynamic> requestBody = {
      'vehicle': selectedVehicle?.id ?? '',
      'start_date': APIHelper.toServerDateTimeFormattedStringFromDateTime(
          selectedDate.value),
      'cost': int.tryParse(fuelCost.text),
      'quantity': int.tryParse(quantityFuel.text),
      'bearer': selectedPerson?.$1,
      'start_km': int.tryParse(startedMeter.text),
      'note': note.text,
    };
    RawAPIResponse? response = await APIRepo.addfuel(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseAddFuelTransKey.toCurrentLanguage);
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
        messageText: AppLanguageTranslation.addFuelTransKey.toCurrentLanguage);
    return;
  }

  Future<void> updateFuel() async {
    final Map<String, dynamic> requestBody = {
      '_id': fuelItemId,
      'vehicle': selectedVehicle?.id ?? '',
      'start_date': APIHelper.toServerDateTimeFormattedStringFromDateTime(
          selectedDate.value),
      'cost': int.tryParse(fuelCost.text),
      'quantity': int.tryParse(quantityFuel.text),
      'bearer': selectedPerson?.$1,
      'start_km': int.tryParse(startedMeter.text),
      'note': note.text,
    };
    RawAPIResponse? response = await APIRepo.updateFuel(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseUpdateFuelTransKey.toCurrentLanguage);
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

  Future<void> getFuelDetails() async {
    FuelDetailsResponse? response =
        await APIRepo.getFuelDetails(fuelItemId: fuelItemId);
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

  onSuccessRetrievingDetails(FuelDetailsResponse response) {
    FuelDetailsData fuelDetails = response.data;
    final foundSelected = vehicleList
        .firstWhereOrNull((element) => element.id == fuelDetails.vehicle.id);
    if (foundSelected != null) {
      selectedVehicle = foundSelected;
      update();
    }
    selectedDate.value = fuelDetails.startDate;
    fuelCost.text = fuelDetails.cost.toString();
    quantityFuel.text = fuelDetails.quantity.toString();
    final foundSelectedPerson = listOfPerson
        .firstWhereOrNull((element) => element.$1 == fuelDetails.bearer);
    if (foundSelectedPerson != null) {
      selectedPerson = foundSelectedPerson;
      update();
    }
    startedMeter.text = fuelDetails.startKm.toString();
    note.text = fuelDetails.status; //Need to review
    update();
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      fuelItemId = params;
      update();
      log('Fuel Item Id: $fuelItemId');
    }
  }

  @override
  void onInit() async {
    _getScreenParameters();
    await getCarElementsRide();
    if (fuelItemId.isNotEmpty) {
      getFuelDetails();
    }

    super.onInit();
  }
}
