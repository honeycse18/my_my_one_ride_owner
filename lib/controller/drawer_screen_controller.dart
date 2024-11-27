import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/home_navigator/home_navigator_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/user_details_response.dart';
import 'package:one_ride_car_owner/screens/history_screen.dart';
import 'package:one_ride_car_owner/screens/home_navigator_screens/home_screen.dart';
import 'package:one_ride_car_owner/screens/home_navigator_screens/tracking_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/message_list_screen.dart';
import 'package:one_ride_car_owner/screens/my_wallet_screen.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class ZoomDrawerScreenController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  HomeNavigatorScreenController homeNavigatorScreenController =
      HomeNavigatorScreenController();

  Widget nestedScreenWidget = const Scaffold();
  int currentPageIndex = 0;

  void nevigateToTab(int selectedPageIndex) {
    currentPageIndex = selectedPageIndex;
    setCurrentTab();
  }

  void gotoSignInScreen() async {
    await AppDialogs.showExpireDialog(
      messageText:
          AppLanguageTranslation.sessionExpiredTransKey.toCurrentLanguage,
    );
    Get.offAllNamed(AppPageNames.logInScreen, arguments: true);
  }

  Future<void> getLoggedInUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      onErrorGetLoggedInUserDetails(response);
      return;
    } else if (response.error) {
      onFailureGetLoggedInUserDetails(response);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInDriverDetails(response);
  }

  void onErrorGetLoggedInUserDetails(UserDetailsResponse? response) {
    gotoSignInScreen();
  }

  void onFailureGetLoggedInUserDetails(UserDetailsResponse response) {
    gotoSignInScreen();
  }

  void onSuccessGetLoggedInDriverDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    BuildContext? context = Get.context;
    if (context != null) {
      Get.toNamed(AppPageNames.zoomDrawerScreen);
    }
  }

  /* <-------- Select current tab screen --------> */
  void setCurrentTab() {
    const int homeScreenIndex = 0;
    const int trackingScreenIndex = 1;
    const int historyScreenIndex = 2;
    const int messageScreenIndex = 3;
    const int walletScreenIndex = 4;
    switch (currentPageIndex) {
      case homeScreenIndex:
        nestedScreenWidget = const HomeScreen();
        break;
      case trackingScreenIndex:
        nestedScreenWidget = const TrackingScreen();
        break;
      case historyScreenIndex:
        nestedScreenWidget = const MyHistoryListScreen();
        break;
      case messageScreenIndex:
        nestedScreenWidget = const MessageListScreen();
        break;
      case walletScreenIndex:
        nestedScreenWidget = const MyWalletScreen();
        break;
      default:
        // Invalid page index set tab to dashboard screen
        nestedScreenWidget = const HomeScreen();
        break;
    }

    update();
  }

  Widget bottomMenuButton(String name, String image, int index) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPictureAssetWidget(
            image,
            color: (currentPageIndex == index)
                ? AppColors.navBarIconColor
                : AppColors.mainTextColor,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: (currentPageIndex == index)
                          ? AppColors.navBarIconColor
                          : AppColors.mainTextColor,
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
      onTap: () {
        selectHomeNavigatorTabIndex(index);
      },
    );
  }

  void selectHomeNavigatorTabIndex(int index) {
    currentPageIndex = index;
    setCurrentTab();
    homeNavigatorScreenController.selectHomeNavigatorTabIndex(index);
  }

  void _getHomeNavigatorController() {
    homeNavigatorScreenController =
        Get.put<HomeNavigatorScreenController>(HomeNavigatorScreenController());
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument != null) {
      if (argument is int) {
        currentPageIndex = argument;
      }
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    _getHomeNavigatorController();
    setCurrentTab();
    super.onInit();
  }
}
