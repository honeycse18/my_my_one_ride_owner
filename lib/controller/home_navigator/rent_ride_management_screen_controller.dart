import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_vehicle_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/ride_car_list_response.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class RentRideScreenControllerScreenController extends GetxController {
  bool isActive = false;
  final PagingController<int, RentVehicleItems> rentVehiclePagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, RideCarListItems> rideVehiclePagingController =
      PagingController(firstPageKey: 1);
  RxBool isRideTabSelected = false.obs;
  // RxBool isRentTabSelected = false.obs;
//------------Rent Section--------------------
  Future<void> toggleRentChanges(
      bool value, RentVehicleItems rentVehicleList) async {
    rentVehicleList.active = value;
    update();
    final Map<String, Object> requestBody = {
      '_id': rentVehicleList.id,
      'active': rentVehicleList.active,
    };
    RawAPIResponse? response = await APIRepo.editRentActiveStatus(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessEditingAccountResponse(response);
  }

  void _onSuccessEditingAccountResponse(RawAPIResponse response) {
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

//------------Rent Section--------------------
  Future<void> deletRideChanges(String id) async {
    final Map<String, String> requestBody = {
      '_id': id,
    };
    RawAPIResponse? response = await APIRepo.deletRideActiveStatus(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessDeletAccountResponse(response);
  }

  void _onSuccessDeletAccountResponse(RawAPIResponse response) {
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

//------------Rent Section--------------------
  Future<void> deletRentChanges(String id) async {
    final Map<String, String> requestBody = {
      '_id': id,
    };
    RawAPIResponse? response = await APIRepo.deletRentActiveStatus(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessDeletRentAccountResponse(response);
  }

  void _onSuccessDeletRentAccountResponse(RawAPIResponse response) {
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  Future<void> getRentVehicleList(int currentPageNumber) async {
    RentVehicleListResponse? response =
        await APIRepo.getRentVehicleList(page: currentPageNumber);
    if (response == null) {
      onErrorGetRentVehicleList(response);
      return;
    } else if (response.error) {
      onFailureGetRentVehicleList(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetRentVehicleList(response);
  }

  void onErrorGetRentVehicleList(RentVehicleListResponse? response) {
    rentVehiclePagingController.error = response;
  }

  void onFailureGetRentVehicleList(RentVehicleListResponse response) {
    rentVehiclePagingController.error = response;
  }

  void onSuccessGetRentVehicleList(RentVehicleListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      rentVehiclePagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    rentVehiclePagingController.appendPage(response.data.docs, nextPageNumber);
  }

  //------------------------ Ride Section-------------------
  Future<void> toggleRideChanges(
      bool value, RideCarListItems rentVehicleList) async {
    rentVehicleList.active = value;
    update();
    final Map<String, Object> requestBody = {
      '_id': rentVehicleList.id,
      'active': rentVehicleList.active,
    };
    RawAPIResponse? response = await APIRepo.editRideActiveStatus(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessEditingAccountStatusResponse(response);
  }

  void _onSuccessEditingAccountStatusResponse(RawAPIResponse response) {
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  Future<void> getRideVehicleList(int currentPageNumber) async {
    RideCarListResponse? response =
        await APIRepo.getRideVehicleList(page: currentPageNumber);
    if (response == null) {
      onErrorGetRideVehicleList(response);
      return;
    } else if (response.error) {
      onFailureGetRideVehicleList(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetRideVehicleList(response);
  }

  void onErrorGetRideVehicleList(RideCarListResponse? response) {
    rideVehiclePagingController.error = response;
  }

  void onFailureGetRideVehicleList(RideCarListResponse response) {
    rideVehiclePagingController.error = response;
  }

  void onSuccessGetRideVehicleList(RideCarListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      rideVehiclePagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    rideVehiclePagingController.appendPage(response.data.docs, nextPageNumber);
  }

  @override
  void onInit() {
    rentVehiclePagingController.addPageRequestListener((pageKey) {
      getRentVehicleList(pageKey);
    });
    rideVehiclePagingController.addPageRequestListener((pageKey) {
      getRideVehicleList(pageKey);
    });
    super.onInit();
  }
}
