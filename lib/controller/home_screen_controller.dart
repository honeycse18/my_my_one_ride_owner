import 'dart:math';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/dashboard_response.dart';
import 'package:one_ride_car_owner/models/api_responses/get_wallet_details_response.dart';
import 'package:one_ride_car_owner/models/fakeModel/home_screen_service_cards.dart';
import 'package:one_ride_car_owner/models/ui/home_graph.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';

class HomeScreenController extends GetxController {
  WalletDetailsItem walletDetails = WalletDetailsItem.empty();

  // Variables
  RxBool toggleNotification = true.obs;
  List<HomeGraphData> earningGraphData = [];
  Rx<DashboardInfo?> selectedCar = Rx<DashboardInfo?>(null);
  // Rx<DashboardInfoVehicle?> selectedCar = Rx<DashboardInfoVehicle?>(null);
  DashboardInfo dashboardInfo = DashboardInfo();
  DashboardInfoVehicle? selectedVehicle;
  RxInt randomTwoDigitNumber = 0.obs;

  var rng = Random();

  void fillList() {
    Random random = Random();
    randomTwoDigitNumber.value = 10 + random.nextInt(90);
    return;
  }

  void updateSelectedCar(DashboardInfo? car) {
    selectedCar.value = car;
  }

  List<ServiceReminderCard> cards = [
    ServiceReminderCard(
        icon: AppAssetImages.email,
        title: 'Maintenance',
        count: 2,
        cardBackgroundColor: const Color(0xfffbefe2),
        iconBackgroundColor: const Color(0xfff79c39)),
    ServiceReminderCard(
        icon: AppAssetImages.arrowDownSVGLogoLine,
        title: 'Service',
        count: 462,
        cardBackgroundColor: const Color(0xffeeecfa),
        iconBackgroundColor: const Color(0xff7a63eb)),
    ServiceReminderCard(
        icon: AppAssetImages.cameraEdit,
        title: 'Fuel Alert',
        count: 238,
        cardBackgroundColor: const Color(0xff4acbf8),
        iconBackgroundColor: const Color(0xffe6f4fc),
        isShowMoneySymbol: true),
  ];

  // Functions
  BarTooltipItem getBarTooltipItem(BarChartGroupData group, int groupIndex,
      BarChartRodData rod, int rodIndex) {
    return BarTooltipItem(
        rod.toY.toInt().toString(),
        AppTextStyles.bodyBoldTextStyle.copyWith(
            color: rodIndex == 0 ? AppColors.rideColor : AppColors.rentColor));
  }

  Future<void> getWalletDetails() async {
    GetWalletDetailsResponse? response = await APIRepo.getWalletDetails();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessGetWalletDetails(response);
  }

  void onSuccessGetWalletDetails(GetWalletDetailsResponse response) {
    walletDetails = response.data;
    update();
  }

  Future<void> getDashboardInfo() async {
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    final DashboardResponse? response =
        await APIRepo.getDashboardInfos({'timezone': currentTimeZone});
    if (response == null) {
      gotoSignInScreen();
      return;
    } else if (response.error) {
      gotoSignInScreen();
      return;
    }
    _onSuccessGetDashboardInfo(response);
  }

  void _onSuccessGetDashboardInfo(DashboardResponse response) {
    dashboardInfo = response.data;
    selectedVehicle = dashboardInfo.vehicles.firstOrNull;
    update();
    final rides = response.data.ridesAsObjects;
    final rents = response.data.rentsAsObjects;
    final Set<DateTime> dates = {};
    dates.addAll(rides.map((e) => e.date));
    dates.addAll(rents.map((e) => e.date));
    final sortedDates = dates.toList();
    sortedDates.sort((a, b) => a.compareTo(b));
    dates.clear();
    dates.addAll(sortedDates);
    earningGraphData = dates.map((date) {
      final foundRide = rides.firstWhereOrNull((ride) =>
          ((ride.date.year == date.year) &&
              (ride.date.month == date.month) &&
              (ride.date.day == date.day)));
      final foundRent = rents.firstWhereOrNull((ride) =>
          ((ride.date.year == date.year) &&
              (ride.date.month == date.month) &&
              (ride.date.day == date.day)));
      return HomeGraphData(
          date: date,
          rideCount: foundRide?.rideCount ?? 0,
          rentCount: foundRent?.rentCount ?? 0);
    }).toList();
    update();
  }

  void gotoSignInScreen() async {
    // Get.snackbar(
    //     '', AppLanguageTranslation.sessionExpiredTransKey.toCurrentLanguage,
    //     colorText: Colors.white);
    await Get.offAllNamed(AppPageNames.logInScreen, arguments: true);
  }

  @override
  void onInit() {
    getDashboardInfo();
    getWalletDetails();
    fillList();

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
