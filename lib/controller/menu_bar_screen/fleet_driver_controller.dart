import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/add_driver_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class FleetPermissionDriverScreenController extends GetxController {
  RxBool isFleetActive = false.obs;
  Rx<AddedDriverListItem> addedDriverListDetails =
      AddedDriverListItem.empty().obs;

  Future<void> toggleFleetChanges(bool value) async {
    isFleetActive.value = value;
    update();
    final Map<String, dynamic> requestBody = {
      '_id': addedDriverListDetails.value.id,
      'fleet': isFleetActive.value,
    };

    RawAPIResponse? response = await APIRepo.toggleFleetChanges(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessFleetPermissionResponse(response);
  }

  _onSuccessFleetPermissionResponse(RawAPIResponse response) {
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is AddedDriverListItem) {
      addedDriverListDetails.value = argument;
      isFleetActive.value = addedDriverListDetails.value.fleet;
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameters();
    super.onInit();
  }
}
