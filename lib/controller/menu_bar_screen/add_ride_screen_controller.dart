import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_car_elements_response.dart';
import 'package:one_ride_car_owner/models/api_responses/ride_details_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class AddRideScreenController extends GetxController {
  String rideId = '';
  RideDetailsData? rideDetailsData;
  RentCarElementsData rideCarElements = RentCarElementsData();
  List<RentCarElementsVehicle> vehicleList = [];
  List<RentCarElementsDriver> driverList = [];

  RentCarElementsVehicle? selectedVehicle;
  RentCarElementsDriver? selectedDriver;

  void onAddVehicleButtonTap() {
    log('button got tapped!');
    addVehicle();
  }

  Future<void> addVehicle() async {
    bool patch = false;
    final Map<String, dynamic> requestBody = {
      'vehicle': selectedVehicle?.id ?? '',
      'driver': selectedDriver?.id ?? ''
    };
    if (rideId.isNotEmpty) {
      requestBody['_id'] = rideId;
      patch = true;
    }
    // String requestBodyJson = jsonEncode(requestBody);
    RawAPIResponse? response =
        await APIRepo.addVehicleToRide(requestBody, patch);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseAddVehicleRideTransKey.toCurrentLanguage);
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
            AppLanguageTranslation.vehicleAddedRideTransKey.toCurrentLanguage);
    return;
  }

  Future<void> getCarElementsRide() async {
    RentCarElementsResponse? response = await APIRepo.getRideCarElements();
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseElementTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingElements(response);
  }

  onSuccessRetrievingElements(RentCarElementsResponse response) {
    rideCarElements = response.data;
    vehicleList = response.data.vehicles;
    driverList = response.data.drivers;
    update();
  }

  Future<void> getRideDetails() async {
    RideDetailsResponse? response =
        await APIRepo.getRideDetails(rideId: rideId);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForRideTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingRideDetails(response);
  }

  onSuccessGettingRideDetails(RideDetailsResponse response) {
    rideDetailsData = response.data;
    selectedVehicle = rideDetailsData!.vehicle;
    selectedDriver = rideDetailsData!.driver;
    final foundSelectedVehicle = vehicleList
        .firstWhereOrNull((element) => element.id == selectedVehicle?.id);
    selectedVehicle = foundSelectedVehicle;
    final foundSelectedDriver = driverList
        .firstWhereOrNull((element) => element.id == selectedDriver?.id);
    selectedDriver = foundSelectedDriver;
    update();
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      rideId = params;
      update();
    }
  }

  @override
  void onInit() async {
    _getScreenParameters();
    await getCarElementsRide();
    if (rideId.isNotEmpty) {
      getRideDetails();
    }
    super.onInit();
  }

  Widget rentCarElementsVehicle(RentCarElementsVehicle vehicle) {
    String status = 'Available';
    if (vehicle.rent.isNotEmpty) {
      status = 'On Rent';
    } else if (vehicle.ride.isNotEmpty) {
      status = 'On Ride';
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: CachedNetworkImageWidget(
                imageURL: vehicle.images.firstOrNull ?? ''),
          ),
          AppGaps.wGap5,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(vehicle.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (vehicle.rent.isNotEmpty ||
                                      vehicle.ride.isNotEmpty)
                                  ? Colors.red
                                  : Colors.green),
                        ),
                        AppGaps.wGap5,
                        Text(status,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.bodyTextColor))
                      ],
                    ),
                  ],
                ),
                Text(vehicle.vehicleNumber)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rentCarElementsDriver(RentCarElementsDriver driver) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: CachedNetworkImageWidget(imageURL: driver.image),
          ),
          AppGaps.wGap5,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(driver.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
              Row(
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            (driver.rent.isNotEmpty || driver.ride.isNotEmpty)
                                ? Colors.red
                                : Colors.green),
                  ),
                  AppGaps.wGap5,
                  Text(driver.uid),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
