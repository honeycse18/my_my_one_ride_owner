import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/get_driver_list_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class AddDriverBottomSheetScreenController extends GetxController {
  TextEditingController searchDriver = TextEditingController();
  FocusNode focusSearchDriver = FocusNode();
  List<GetDriverListItem> getDriverItem = [];
  void onSearchChanges(String text) {
    if (text.isNotEmpty) {
      getDriver(text);
    }
  }

//--------------get method---------------
  Future<void> getDriver([String? text]) async {
    GetDriverListResponse? response =
        await APIRepo.getDriver(key: text ?? searchDriver.text);
    if (response == null) {
      APIHelper.onError(response?.msg);

      return;
    } else if (response.error) {
      // APIHelper.onFailure(response.msg);

      return;
    }
    log((response.toJson().toString()));
    _onSuccessDriverList(response);
  }

  void _onSuccessDriverList(GetDriverListResponse response) {
    getDriverItem = response.data;
    update();
  }

  //------------post method---------------
  Future<void> addDriver(String driverId) async {
    Map<String, dynamic> requestBody = {
      'driver': driverId,
    };
    RawAPIResponse? response = await APIRepo.addDriver(requestBody);
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
    await AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.requestSentTransKey.toCurrentLanguage);
    Get.back();
  }

  @override
  void onInit() {
    getDriver();
    super.onInit();
  }

  @override
  void onReady() {
    focusSearchDriver.requestFocus();
    super.onReady();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusSearchDriver.dispose();
    searchDriver.dispose();
    super.dispose();
  }
}
