import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/socket_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/driver_request_update_socket_response.dart';
import 'package:one_ride_car_owner/models/api_responses/new_hire_socket_response.dart';
import 'package:one_ride_car_owner/models/api_responses/new_rent_socket_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_status_socket_response.dart';
import 'package:one_ride_car_owner/screens/home_navigator_screens/tracking_screen.dart';
import 'package:one_ride_car_owner/screens/unknown_screen.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class HomeNavigatorScreenController extends GetxController {
  Widget nestedScreenWidget = const Scaffold();
  int currentPageIndex = 0;
  NewRentSocketResponse newRentData = NewRentSocketResponse.empty();
  RentStatusSocketResponse rentStatusUpdate = RentStatusSocketResponse.empty();
  DriverRequestUpdateSocketResponse driverRequestUpdate =
      DriverRequestUpdateSocketResponse.empty();
  StreamSubscription<HireSocketResponse>? listener;

  void setCurrentTab() {
    const int productScreenIndex = 0;
    const int trackingScreenIndex = 1;
    const int homeScreenIndex = 2;
    const int messageScreenIndex = 3;
    const int accountScreenIndex = 4;
    switch (currentPageIndex) {
      case productScreenIndex:
        nestedScreenWidget = const UnknownScreen();
        break;
      case trackingScreenIndex:
        nestedScreenWidget = const TrackingScreen();
        break;
      case homeScreenIndex:
        // nestedScreenWidget = const HomeScreen();
        break;
      case messageScreenIndex:
        // nestedScreenWidget = const ChatDeliverymanScreen();
        // nestedScreenWidget = const MessageRecipientsScreen();
        // nestedScreenWidget = const ChatRecipientsScreen();
        break;
      case accountScreenIndex:
        // nestedScreenWidget = const ProfileScreen();
        break;
      default:
        // Invalid page index set tab to dashboard screen
        nestedScreenWidget = const UnknownScreen();
      // nestedScreenWidget = const HomeScreen();
    }
    update();
  }

  /* <-------- Select current tab screen --------> */

  Widget bottomMenuButton(String name, String image, int index) {
    return GestureDetector(
      child: Container(
        width: 50,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPictureAssetWidget(
              image,
              color: (currentPageIndex == index)
                  ? AppColors.primaryColor
                  : AppColors.bodyTextColor,
            ),
            AppGaps.hGap4,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: (currentPageIndex == index)
                            ? AppColors.primaryColor
                            : AppColors.bodyTextColor,
                        fontSize: 12,
                        fontWeight: (currentPageIndex == index)
                            ? FontWeight.w500
                            : FontWeight.normal),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        selectHomeNavigatorTabIndex(index);
      },
    );
  }

  void selectHomeNavigatorTabIndex(int index) {
    currentPageIndex = index;
    setCurrentTab();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument != null) {
      if (argument is int) {
        currentPageIndex = argument;
      }
    }
  }

  dynamic onNewRent(dynamic data) {
    if (data is NewRentSocketResponse) {
      newRentData = data;
      update();
      if (newRentData.id.isNotEmpty) {
        AppDialogs.showSuccessDialog(
            messageText:
                AppLanguageTranslation.haveNewRentTransKey.toCurrentLanguage);
      }
    }
  }

  dynamic onRentStatusUpdate(dynamic data) {
    if (data is RentStatusSocketResponse) {
      rentStatusUpdate = data;
      update();
      if (rentStatusUpdate.id.isNotEmpty) {
        AppDialogs.showSuccessDialog(
            messageText:
                AppLanguageTranslation.newRentUpdateTransKey.toCurrentLanguage);
      }
    }
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

  void _checkHireUpdate() {
    final SocketController socketController = Get.find<SocketController>();
    if (listener == null) {
      listener = socketController.hireDetails.listen((p0) {});
      listener?.onData((data) {
        AppDialogs.showSuccessDialog(
            messageText: AppLanguageTranslation
                .hireDriverHasUpdateTransKey.toCurrentLanguage);
      });
    }
  }

  late StreamSubscription<NewRentSocketResponse> listen;
  late StreamSubscription<RentStatusSocketResponse> listen2;
  late StreamSubscription<DriverRequestUpdateSocketResponse> listen3;

  @override
  void onInit() {
    _getScreenParameter();
    setCurrentTab();
    SocketController socketController = Get.find<SocketController>();
    listen = socketController.newRentSocketData.listen((p0) {
      onNewRent(p0);
    });
    listen2 = socketController.rentStatusSocketData.listen((p0) {
      onRentStatusUpdate(p0);
    });
    listen3 = socketController.driverRequestUpdateData.listen((p0) {
      onDriverRequestUpdate(p0);
    });
    _checkHireUpdate();
    super.onInit();
  }

  @override
  void onClose() {
    listen.cancel();
    listen2.cancel();
    listen3.cancel();
    super.onClose();
  }
}
