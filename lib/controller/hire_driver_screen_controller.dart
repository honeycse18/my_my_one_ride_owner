import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/driver_details_response.dart';
import 'package:one_ride_car_owner/models/api_responses/nearest_driver_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class DriverDetailsScreenController extends GetxController {
  NearestDriverList hireDriver = NearestDriverList.empty();
  DriverDetailsData driverDetails = DriverDetailsData.empty();

  Future<void> getDriverDetails(String driverId) async {
    DriverDetailsResponse? response =
        await APIRepo.getDriverDetails(driverId: driverId);
    if (response == null) {
      Helper.showSnackBar(
          AppLanguageTranslation.noDriverDetailsTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingDriverDetails(response);
  }

  onSuccessRetrievingDriverDetails(DriverDetailsResponse response) {
    driverDetails = response.data;
    update();
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is NearestDriverList) {
      hireDriver = argument;
      if (hireDriver.id.isNotEmpty) {
        getDriverDetails(hireDriver.id);
      }
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
