import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_car_elements_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_details_response.dart';
import 'package:one_ride_car_owner/models/location_model.dart';
import 'package:one_ride_car_owner/models/screenParameters/select_screen_parameters.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class AddRentScreenController extends GetxController {
  String rentId = '';
  RentDetailsData? rentDetailsData;
  RentCarElementsData rentCarElements = RentCarElementsData();
  List<RentCarElementsVehicle> vehicleList = [];
  List<RentCarElementsDriver> driverList = [];
  LocationModel? vehicleLocation;
  bool driverIncluded = false;
  bool smokingAllowed = false;

  RentCarElementsVehicle? selectedVehicle;
  RentCarElementsDriver? selectedDriver;
  TextEditingController weeklyCarRentTextEditingController =
      TextEditingController(text: '0');
  TextEditingController hourlyCarRentTextEditingController =
      TextEditingController(text: '0');
  TextEditingController monthlyCarRentTextEditingController =
      TextEditingController(text: '0');
  TextEditingController vehicleLocationTextController = TextEditingController();
  TextEditingController luggageSpaceTextController = TextEditingController();

  bool hourlyChecked = false;
  bool weeklyChecked = false;
  bool monthlyChecked = false;

  bool onCheckBoxUpdate(TextEditingController controller, bool toChange,
      {bool? value}) {
    bool ret;
    if (value != null) {
      ret = value;
    } else {
      ret = !toChange;
    }
    update();
    if (!ret) {
      controller.text = '0';
      update();
    }
    return ret;
  }

  void onAddVehicleButtonTap() {
    log('button got tapped!');
    addVehicle();
  }

  Future<void> addVehicle() async {
    final Map<String, dynamic> requestBody = getRequestBody();
    // String requestBodyJson = jsonEncode(requestBody);
    RawAPIResponse? response =
        await APIRepo.addVehicleToRent(requestBody, patch: rentId.isNotEmpty);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseAddVehicleTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessAddingVehicleForRent(response);
  }

  onSuccessAddingVehicleForRent(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.addedVehicleTransKey.toCurrentLanguage);
  }

  Map<String, dynamic> getRequestBody() {
    final Map<String, dynamic> facilities = {
      'smoking': smokingAllowed,
      'luggage': luggageSpaceTextController.text
    };
    final Map<String, dynamic> hourly = {
      'active': hourlyChecked,
      'price': hourlyCarRentTextEditingController.text
    };
    final Map<String, dynamic> weekly = {
      'active': weeklyChecked,
      'price': weeklyCarRentTextEditingController.text
    };
    final Map<String, dynamic> monthly = {
      'active': monthlyChecked,
      'price': monthlyCarRentTextEditingController.text
    };
    final Map<String, dynamic> prices = {
      'hourly': hourly,
      'weekly': weekly,
      'monthly': monthly
    };
    final Map<String, dynamic> location = {
      'lat': vehicleLocation?.latitude ?? 0.0,
      'lng': vehicleLocation?.longitude ?? 0.0
    };
    Map<String, dynamic> requestBody = {
      'vehicle': selectedVehicle?.id ?? '',
      'has_driver': driverIncluded,
      'address': vehicleLocationTextController.text,
      'location': location,
      'prices': prices,
      'facilities': facilities
    };
    if (driverIncluded) {
      requestBody['driver'] = selectedDriver?.id ?? '';
    }
    if (rentId.isNotEmpty) {
      requestBody['_id'] = rentId;
    }
    return requestBody;
  }

  Future<void> _getRentCarElements() async {
    RentCarElementsResponse? response = await APIRepo.getRentCarElements();
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
    rentCarElements = response.data;
    vehicleList = response.data.vehicles;
    driverList = response.data.drivers;
    update();
  }

  void onLocationTap() async {
    dynamic res = await Get.toNamed(AppPageNames.selectLocation,
        arguments: SelectLocationScreenParameters(
            screenTitle:
                AppLanguageTranslation.selectLocTransKey.toCurrentLanguage,
            showCurrentLocationButton: true,
            locationModel: vehicleLocation));
    if (res is LocationModel) {
      vehicleLocation = res;
      vehicleLocationTextController.text =
          vehicleLocation?.address ?? 'Vehicle Location';
      update();
      // log(res);
    }
  }

  Future<void> getRentDetails() async {
    RentDetailsResponse? response =
        await APIRepo.fetchRentDetails(rentId: rentId);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseRentDetailsTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessFetchingRentDetails(response);
  }

  onSuccessFetchingRentDetails(RentDetailsResponse response) {
    rentDetailsData = response.data;
    selectedVehicle = rentDetailsData!.vehicle;
    selectedDriver = rentDetailsData!.driver;
    final foundSelectedVehicle = vehicleList
        .firstWhereOrNull((element) => element.id == selectedVehicle?.id);
    selectedVehicle = foundSelectedVehicle;
    final foundSelectedDriver = driverList
        .firstWhereOrNull((element) => element.id == selectedDriver?.id);
    selectedDriver = foundSelectedDriver;
    driverIncluded = rentDetailsData!.hasDriver;
    vehicleLocationTextController.text = rentDetailsData!.address;
    vehicleLocation = LocationModel(
        latitude: rentDetailsData!.location.lat,
        longitude: rentDetailsData!.location.lng,
        address: rentDetailsData!.address);
    hourlyChecked = rentDetailsData!.prices.hourly.active;
    weeklyChecked = rentDetailsData!.prices.weekly.active;
    monthlyChecked = rentDetailsData!.prices.monthly.active;
    hourlyCarRentTextEditingController.text =
        rentDetailsData!.prices.hourly.price.toString();
    weeklyCarRentTextEditingController.text =
        rentDetailsData!.prices.weekly.price.toString();
    monthlyCarRentTextEditingController.text =
        rentDetailsData!.prices.monthly.price.toString();
    smokingAllowed = rentDetailsData!.facilities.smoking;
    luggageSpaceTextController.text =
        rentDetailsData!.facilities.luggage.toString();
    update();
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      rentId = params;
      update();
    }
  }

  @override
  void onInit() async {
    _getScreenParameters();
    await _getRentCarElements();
    if (rentId.isNotEmpty) {
      getRentDetails();
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
                  AppGaps.wGap7,
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
