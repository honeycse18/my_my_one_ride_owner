import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_history_list_response.dart';
import 'package:one_ride_car_owner/screens/bottom_sheet/choose_reason_ride_cancel_bottomsheet.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class RentDetailsScreenController extends GetxController {
  RentHistoryList historyDetails = RentHistoryList.empty();

  //------------post method---------------
  Future<void> updateRentStatus(String id, String status) async {
    Map<String, dynamic> requestBody = {'_id': id, 'status': status};
    RawAPIResponse? response = await APIRepo.updateRentStatus(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    AppDialogs.showConfirmDialog(
        messageText: AppLanguageTranslation.doYouSureTransKey.toCurrentLanguage,
        onYesTap: () async {
          await _onSucessUpdateRentStatus(response);
        });
  }

  _onSucessUpdateRentStatus(RawAPIResponse response) {
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  void cancelRentStatus(String id, String status) async {
    String reason = AppLanguageTranslation.noReasonTransKey.toCurrentLanguage;

    dynamic res =
        await Get.bottomSheet(const ChooseReasonCancelRideBottomSheet());
    if (res is String) {
      reason = res;
      update();
    }
    cancelPostRentStatus(id, status, reason);
  }

  //------------post method---------------
  Future<void> cancelPostRentStatus(
      String id, String status, String reason) async {
    Map<String, dynamic> requestBody = {
      '_id': id,
      'status': status,
      'cancel_reason': reason
    };
    RawAPIResponse? response = await APIRepo.updateRentStatus(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSucessCancelRentStatus(response);
  }

  _onSucessCancelRentStatus(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  //------------post start method---------------
  Future<void> startPostRentStatus(
    String id,
    String status,
  ) async {
    Map<String, dynamic> requestBody = {'_id': id, 'status': status};
    RawAPIResponse? response = await APIRepo.startRentStatus(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSucessStartRentStatus(response);
  }

  _onSucessStartRentStatus(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is RentHistoryList) {
      historyDetails = argument;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit

    _getScreenParameters();
    super.onInit();
  }
}
