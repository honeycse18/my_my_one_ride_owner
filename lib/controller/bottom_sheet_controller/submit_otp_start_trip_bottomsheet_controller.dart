import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class SubmitOtpStartRideBottomSheetController extends GetxController {
  bool isSuccess = false;

  TextEditingController otpTextEditingController = TextEditingController();
  String id = '';

  Future<void> startRentStatus() async {
    Map<String, dynamic> requestBody = {
      '_id': id,
      'status': 'started',
      'otp': otpTextEditingController.text,
    };
    RawAPIResponse? response = await APIRepo.startRentStatus(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessStartRideRequest(response);
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  _onSuccessStartRideRequest(RawAPIResponse response) async {
    return isSuccess = true;
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is String) {
      id = argument;
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    otpTextEditingController.dispose();
    super.dispose();
  }
}
