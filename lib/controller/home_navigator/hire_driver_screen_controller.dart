import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/socket_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/hire_driver_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/new_hire_socket_response.dart';
import 'package:one_ride_car_owner/models/enums.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';

class HireDriverScreenController extends GetxController {
  Rx<RideDriverTabStatus> hireDriverStatusTab =
      RideDriverTabStatus.driverPending.obs;
  StreamSubscription<HireSocketResponse>? listener;

  final PagingController<int, HireDriverListItem> hireDriverPagingController =
      PagingController(firstPageKey: 1);

  void onTabTap(RideDriverTabStatus value) {
    hireDriverStatusTab.value = value;
    hireDriverPagingController.refresh();
    update();
  }

  Future<void> getHireDriverList(int currentPageNumber) async {
    final String key = hireDriverStatusTab.value.stringValue;
    HireDriverListResponse? response =
        await APIRepo.getHireDriverList(page: currentPageNumber, key: key);
    if (response == null) {
      onErrorGetHireDriverList(response);
      return;
    } else if (response.error) {
      onFailureGetHireDriverList(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetHireDriverList(response);
  }

  void onErrorGetHireDriverList(HireDriverListResponse? response) {
    hireDriverPagingController.error = response;
  }

  void onFailureGetHireDriverList(HireDriverListResponse response) {
    hireDriverPagingController.error = response;
  }

  void onSuccessGetHireDriverList(HireDriverListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      hireDriverPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    hireDriverPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  void _checkHireUpdate() {
    final SocketController socketController = Get.find<SocketController>();
    if (listener == null) {
      listener = socketController.hireDetails.listen((p0) {});
      listener?.onData((data) {
        hireDriverPagingController.refresh();
        update();
      });
    }
  }

  @override
  void onInit() {
    hireDriverPagingController.addPageRequestListener((pageKey) {
      getHireDriverList(pageKey);
    });

    _checkHireUpdate();
    super.onInit();
  }
}
