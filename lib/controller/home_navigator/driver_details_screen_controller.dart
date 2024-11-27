import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/add_driver_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class DriverDetailsScreenController extends GetxController {
  AddedDriverListItem addedDriverListDetails = AddedDriverListItem.empty();

  void removeThisDriver(String driverId) async {
    await AppDialogs.showConfirmDialog(
        shouldCloseDialogOnceYesTapped: false,
        messageText:
            AppLanguageTranslation.wantRemoveDriverTransKey.toCurrentLanguage,
        onYesTap: () async {
          await removeDriver(driverId);
        });
    Get.back();
  }

//------------post method---------------
  Future<void> removeDriver(String driverId) async {
    Map<String, String> requestBody = {
      '_id': driverId,
    };
    RawAPIResponse? response = await APIRepo.removeDriver(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessAddDriver(response);
  }

  _onSuccessAddDriver(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    Get.back();
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is AddedDriverListItem) {
      addedDriverListDetails = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();

    super.onInit();
  }
}
