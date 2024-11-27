import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/fuel_list_response.dart';
import 'package:one_ride_car_owner/screens/bottom_sheet/fuel_management_complete_bottomsheet.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class FuelManagementScreenController extends GetxController {
  RxBool isActiveSelected = false.obs;
  final PagingController<int, FuelCarListItem> fuelListPagingController =
      PagingController(firstPageKey: 1);

  void onSelectedTap(String fuelItemId, String selectedItem) async {
    if (selectedItem == 'Edit') {
      await Get.toNamed(AppPageNames.addFuelScreen, arguments: fuelItemId);
      fuelListPagingController.refresh();
    }
    if (selectedItem == 'Complete') {
      await Get.bottomSheet(const CompleteFuelManagementBottomSheet(),
          settings: RouteSettings(arguments: fuelItemId));
      fuelListPagingController.refresh();
    }
    if (selectedItem == 'Delete') {
      await deleteFuelRequest(fuelItemId);
      fuelListPagingController.refresh();
    }
  }

  Future<void> deleteFuelRequest(String vehicleId) async {
    final Map<String, String> requestBody = {
      '_id': vehicleId,
    };
    RawAPIResponse? response = await APIRepo.deleteFuelRequest(requestBody);
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
    Get.back();
    await AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.fleetFuelTransKey.toCurrentLanguage);
    return;
  }

  Future<void> getFuelAddedList(int currentPageNumber) async {
    FuelListResponse? response = await APIRepo.getFuelAddedList(
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

  void onErrorGetDriverList(FuelListResponse? response) {
    fuelListPagingController.error = response;
  }

  void onFailureGetDriverList(FuelListResponse response) {
    fuelListPagingController.error = response;
  }

  void onSuccessGetDriverList(FuelListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      fuelListPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    fuelListPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  @override
  void onInit() {
    fuelListPagingController.addPageRequestListener((pageKey) {
      getFuelAddedList(pageKey);
    });
    super.onInit();
  }
}
