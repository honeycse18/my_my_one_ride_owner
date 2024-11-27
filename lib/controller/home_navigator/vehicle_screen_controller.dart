import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/models/api_responses/car_list_response.dart';
import 'package:one_ride_car_owner/models/enums.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';

class VehicleScreenController extends GetxController {
  // RxBool isPendingTabSelected = false.obs;
  Rx<VehicleListStatus> vehicleStatusTab = VehicleListStatus.pending.obs;
  // RxBool isApproveTabSelected = false.obs;

  final PagingController<int, VehicleListItem> vehiclePagingController =
      PagingController(firstPageKey: 1);
  void onTabTap(VehicleListStatus value) {
    vehicleStatusTab.value = value;
    vehiclePagingController.refresh();
    update();
  }

  Future<void> getVehicleList(int currentPageNumber) async {
    final String key = vehicleStatusTab.value.stringValue;
    CarListResponse? response =
        await APIRepo.getVehicleList(page: currentPageNumber, key: key);
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

  void onErrorGetVehicleList(CarListResponse? response) {
    vehiclePagingController.error = response ?? true;
  }

  void onFailureGetVehicleList(CarListResponse response) {
    vehiclePagingController.error = response.error;
  }

  void onSuccessGetVehicleList(CarListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      vehiclePagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    vehiclePagingController.appendPage(response.data.docs, nextPageNumber);
  }

  void onSingleVehicleItemTap(String id) async {
    await Get.toNamed(AppPageNames.vehicleDetailsScreen, arguments: id);
    vehiclePagingController.refresh();
  }

  @override
  void onInit() {
    vehiclePagingController.addPageRequestListener((pageKey) {
      getVehicleList(pageKey);
    });
    super.onInit();
  }
}
