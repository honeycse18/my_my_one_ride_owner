import 'dart:async';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/socket_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/add_driver_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/driver_request_update_socket_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class DriverManagementScreenController extends GetxController {
  final PagingController<int, AddedDriverListItem> driverListPagingController =
      PagingController(firstPageKey: 1);
  DriverRequestUpdateSocketResponse driverRequestUpdate =
      DriverRequestUpdateSocketResponse.empty();

  RxBool isAcceptedSelected = false.obs;
  String status = '';

  Future<void> getDriverList(int currentPageNumber) async {
    AddedDriverListResponse? response = await APIRepo.getAddedDriverList(
        page: currentPageNumber,
        status: !isAcceptedSelected.value ? 'accepted' : 'pending');
    if (response == null) {
      onErrorGetDriverList(response);
      return;
    } else if (response.error) {
      onFailureGetDriverList(response);
      return;
    }
    onSuccessGetDriverList(response);
  }

  void onErrorGetDriverList(AddedDriverListResponse? response) {
    driverListPagingController.error = response;
  }

  void onFailureGetDriverList(AddedDriverListResponse response) {
    driverListPagingController.error = response;
  }

  void onSuccessGetDriverList(AddedDriverListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      driverListPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    driverListPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  dynamic onDriverRequestUpdate(dynamic data) {
    if (data is DriverRequestUpdateSocketResponse) {
      driverRequestUpdate = data;
      update();
      if (driverRequestUpdate.id.isNotEmpty) {
        AppDialogs.showSuccessDialog(
            messageText: AppLanguageTranslation
                .driverRequestHasUpdateTransKey.toCurrentLanguage);
      }
    }
  }

  late StreamSubscription<DriverRequestUpdateSocketResponse> listen3;

  @override
  void onInit() {
    driverListPagingController.addPageRequestListener((pageKey) {
      getDriverList(pageKey);
    });
    SocketController socketController = Get.find<SocketController>();
    listen3 = socketController.driverRequestUpdateData.listen((p0) {
      onDriverRequestUpdate(p0);
    });
    super.onInit();
  }

  @override
  void onClose() {
    listen3.cancel();
    super.onClose();
  }
}
