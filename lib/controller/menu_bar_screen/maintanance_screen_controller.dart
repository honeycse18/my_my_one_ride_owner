import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/maintanance_list_response.dart';
import 'package:one_ride_car_owner/screens/bottom_sheet/maintenence_management_complete_bottomsheet.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class MaintenanceScreenController extends GetxController {
  RxBool isActiveSelected = false.obs;
  final PagingController<int, MaintenanceListItem>
      maintenanceListPagingController = PagingController(firstPageKey: 1);

  void onSelectedTap(String maintenanceId, String selectedItem) async {
    if (selectedItem == 'Edit') {
      await Get.toNamed(AppPageNames.addMaintenenceScreen,
          arguments: maintenanceId);
      maintenanceListPagingController.refresh();
    }
    if (selectedItem == 'Complete') {
      await Get.bottomSheet(const CompleteMaintenanceManagementBottomSheet(),
          settings: RouteSettings(arguments: maintenanceId));
      maintenanceListPagingController.refresh();
    }
    if (selectedItem == 'Delete') {
      await deleteMaintenenceRequest(maintenanceId);
      maintenanceListPagingController.refresh();
    }
  }

  Future<void> deleteMaintenenceRequest(String vehicleId) async {
    final Map<String, String> requestBody = {
      '_id': vehicleId,
    };
    RawAPIResponse? response =
        await APIRepo.deleteMaintenenceRequest(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseFoundCompleteTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessAddingVehicleToRide(response);
  }

  onSuccessAddingVehicleToRide(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.fleetFuelTransKey.toCurrentLanguage);
    return;
  }

  Future<void> getMaintenenceAddedList(int currentPageNumber) async {
    MaintenanceListResponse? response = await APIRepo.getMaintenenceAddedList(
        page: currentPageNumber,
        status: isActiveSelected.value ? 'complete' : 'active');
    if (response == null) {
      onErrorGetDriverList(response);
      return;
    } else if (response.error) {
      onFailureGetDriverList(response);
      return;
    }
    onSuccessGetDriverList(response);
  }

  void onErrorGetDriverList(MaintenanceListResponse? response) {
    maintenanceListPagingController.error = response;
  }

  void onFailureGetDriverList(MaintenanceListResponse response) {
    maintenanceListPagingController.error = response;
  }

  void onSuccessGetDriverList(MaintenanceListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      maintenanceListPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    maintenanceListPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  @override
  void onInit() {
    maintenanceListPagingController.addPageRequestListener((pageKey) {
      getMaintenenceAddedList(pageKey);
    });
    super.onInit();
  }
}
