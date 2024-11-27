import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/hire_driver_details_response.dart';
import 'package:one_ride_car_owner/models/fakeModel/submit_review_screen_parameter.dart';
import 'package:one_ride_car_owner/screens/bottom_sheet/submit_review_bottomSheet.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class HireDriverDetailsScreenController extends GetxController {
  String hireDriverId = '';

  HireDriverListItem hiredDriverDetails = HireDriverListItem.empty();
  RxDouble rate = 0.0.obs;
  void onAddTap() {
    rate.value++;
    update();
  }

  void onRemoveTap() {
    rate.value--;
    update();
  }

  Duration get isDays {
    return hiredDriverDetails.end.date
        .difference(hiredDriverDetails.start.date);
  }

  //------------post start method---------------
  Future<void> acceptRequest() async {
    Map<String, dynamic> requestBody = {
      '_id': hireDriverId,
      'status': 'accepted',
    };
    RawAPIResponse? response = await APIRepo.acceptRequest(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessAcceptHireStatus(response);
  }

  //------------post start method---------------
  //------------post start method---------------
  Future<void> updateRequest() async {
    Map<String, dynamic> requestBody = {
      '_id': hireDriverId,
      // 'status': 'accepted',
      'amount': rate.value,
    };
    RawAPIResponse? response = await APIRepo.updateRequest(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessUpdateRequest(response);
  }

  _onSuccessUpdateRequest(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    Get.back();
  }

  _onSuccessAcceptHireStatus(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    Get.back();
  }

  //------------post start method---------------
  Future<void> rejectRequest() async {
    Map<String, dynamic> requestBody = {
      '_id': hireDriverId,
      'status': 'cancelled',
    };
    RawAPIResponse? response = await APIRepo.acceptRequest(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessRejectRequest(response);
  }

  _onSuccessRejectRequest(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  void reviewDriver() {
    Get.bottomSheet(SubmitReviewBottomSheetScreen(),
        settings: RouteSettings(
            arguments: SubmitReviewScreenParameter(
                id: hireDriverId, type: 'driver_hire')));
  }

  void paymentDriver() {}

  Future<void> getHiredDriverDetails(String hireDriverId) async {
    final HireDriverDetailsResponse? response;
    response = await APIRepo.getHiredDriverDetails(hireDriverId: hireDriverId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessGetHiredDriverDetails(response);
  }

  _onSuccessGetHiredDriverDetails(HireDriverDetailsResponse response) {
    hiredDriverDetails = response.data;
    rate.value = hiredDriverDetails.amount;
    update();
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      hireDriverId = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    getHiredDriverDetails(hireDriverId);
    super.onInit();
  }
}
