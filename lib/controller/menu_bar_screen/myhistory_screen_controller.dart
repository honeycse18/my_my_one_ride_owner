import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/socket_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/new_rent_socket_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_history_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_status_socket_response.dart';
import 'package:one_ride_car_owner/models/enums.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';

class MyHistoryScreenController extends GetxController {
  Rx<TabStatus> vehicleStatusTab = TabStatus.accepted.obs;
  NewRentSocketResponse newRentData = NewRentSocketResponse.empty();
  RentStatusSocketResponse rentStatusUpdate = RentStatusSocketResponse.empty();

  final PagingController<int, RentHistoryList> rentHistoryPagingController =
      PagingController(firstPageKey: 1);
  void onTabTap(TabStatus value) {
    vehicleStatusTab.value = value;
    rentHistoryPagingController.refresh();
    update();
  }

  Future<void> getRentHistoryList(int currentPageNumber) async {
    final String key = vehicleStatusTab.value.stringValue;
    RentHistoryLIstResponse? response =
        await APIRepo.getRentHistoryList(page: currentPageNumber, key: key);
    if (response == null) {
      onErrorGetVehicleList(response);
      return;
    } else if (response.error) {
      onFailureGetVehicleList(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetVehicleList(response);
  }

  void onErrorGetVehicleList(RentHistoryLIstResponse? response) {
    rentHistoryPagingController.error = response;
  }

  void onFailureGetVehicleList(RentHistoryLIstResponse response) {
    rentHistoryPagingController.error = response;
  }

  void onSuccessGetVehicleList(RentHistoryLIstResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      rentHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    rentHistoryPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  dynamic onNewRent(dynamic data) {
    if (data is NewRentSocketResponse) {
      newRentData = data;
      update();
      if (newRentData.id.isNotEmpty) {
        rentHistoryPagingController.refresh();
      }
    }
  }

  dynamic onRentStatusUpdate(dynamic data) {
    if (data is RentStatusSocketResponse) {
      rentStatusUpdate = data;
      update();
      if (rentStatusUpdate.id.isNotEmpty) {
        rentHistoryPagingController.refresh();
      }
    }
  }

  late StreamSubscription<NewRentSocketResponse> listen;
  late StreamSubscription<RentStatusSocketResponse> listen2;
  @override
  void onInit() {
    rentHistoryPagingController.addPageRequestListener((pageKey) {
      getRentHistoryList(pageKey);
    });
    SocketController socketController = Get.find<SocketController>();
    listen = socketController.newRentSocketData.listen((p0) {
      onNewRent(p0);
    });
    listen2 = socketController.rentStatusSocketData.listen((p0) {
      onRentStatusUpdate(p0);
    });
    super.onInit();
  }

  @override
  void onClose() {
    listen.cancel();
    listen2.cancel();
    super.onClose();
  }
}
