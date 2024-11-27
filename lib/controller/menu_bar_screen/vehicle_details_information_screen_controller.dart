import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/vehicle_details_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/vehicle_details_response.dart';
import 'package:one_ride_car_owner/models/enums.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';

class VehicleDetailsInfoScreenController extends GetxController {
  Rx<VehicleDetailsInfoTypeStatus> vehicleInfoStatusTab =
      VehicleDetailsInfoTypeStatus.specifications.obs;
  VehicleDetailsScreenController vehicleDetailsScreenController =
      VehicleDetailsScreenController();

  final PageController imageController = PageController(keepPage: false);
  final PageController documentController = PageController(keepPage: false);
  List<String> images = [];
  List<String> documents = [];
  VehicleDetailsItem vehicleDetailsItem = VehicleDetailsItem.empty();

  void onEditButtonTap() async {
    await Get.offNamed(AppPageNames.addVehicleScreen,
        arguments: vehicleDetailsItem.id);
    await vehicleDetailsScreenController
        .getVehicleDetails(vehicleDetailsItem.id);
    _updateDetails();
  }

  void onTabTap(VehicleDetailsInfoTypeStatus value) {
    vehicleInfoStatusTab.value = value;
    update();
  }

  void _updateDetails() {
    vehicleDetailsItem = vehicleDetailsScreenController.vehicleDetailsItem;
    update();
  }
  /*  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is VehicleDetailsItem) {
      vehicleDetailsItem = argument;
    }
  } */

  @override
  void onInit() {
    vehicleDetailsScreenController = Get.find<VehicleDetailsScreenController>();
    _updateDetails();
    // TODO: implement onInit
    // _getScreenParameters();

    super.onInit();
  }
}
