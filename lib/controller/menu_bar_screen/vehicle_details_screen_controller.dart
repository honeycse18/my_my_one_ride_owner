import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/vehicle_details_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class VehicleDetailsScreenController extends GetxController {
  String vehicleId = '';
  VehicleDetailsItem vehicleDetailsItem = VehicleDetailsItem.empty();
  final PageController imageController = PageController(keepPage: false);

  List<String> images = [];
  List<String> documents = [];

  Future<void> getVehicleDetails(String productId) async {
    VehicleDetailsResponse? response =
        await APIRepo.getVehicleDetails(productId: productId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetVehicleDetailsResponse(response);
  }

  void _onSuccessGetVehicleDetailsResponse(VehicleDetailsResponse response) {
    vehicleDetailsItem = response.data;
    images = response.data.images;
    documents = response.data.documents;
    update();
  }

  void onRemoveVehicleTap() {
    removeVehicle();
  }

  Future<void> removeVehicle() async {
    RawAPIResponse? response =
        await APIRepo.removeVehicle(vehicleId: vehicleId);
    if (response == null) {
      Helper.showSnackBar(
          AppLanguageTranslation.noResponseRemoveTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRemovingVehicle(response);
  }

  onSuccessRemovingVehicle(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      vehicleId = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    getVehicleDetails(vehicleId);

    super.onInit();
  }
}
