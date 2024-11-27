import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class CompleteMaintenenceScreenController extends GetxController {
  TextEditingController endMeterNumber = TextEditingController();
  String vehicleId = '';
  var selectedDateEnd = DateTime.now().obs;
  void updateSelectedStartDate(DateTime newDate) {
    selectedDateEnd.value = newDate;
    update();
  }

  Future<void> updateMaintenence() async {
    final Map<String, dynamic> requestBody = {
      '_id': vehicleId,
      'end_date': APIHelper.toServerDateTimeFormattedStringFromDateTime(
          selectedDateEnd.value),
      'status': 'complete',
    };
    RawAPIResponse? response = await APIRepo.updateMaintenence(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseFoundCompleteTransKey.toCurrentLanguage);
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
            AppLanguageTranslation.fuelUpdateSuccessTransKey.toCurrentLanguage);
    return;
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      vehicleId = argument;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameters();
    super.onInit();
  }
}
