import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/home_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/dashboard_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/datetime.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final double dpi = MediaQuery.of(context).devicePixelRatio * 160.0;
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.mainBg,
            extendBody: true,
            appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              hasBackButton: false,
              titleWidget: Text(
                AppLanguageTranslation.homeTransKey.toCurrentLanguage,
                style: AppTextStyles.titleBoldTextStyle,
              ),
              leading: Center(
                child: IconButtonWidget(
                  backgroundColor: AppColors.appBarIconTextColor,
                  onTap: () {
                    if (ZoomDrawer.of(context)!.isOpen()) {
                      ZoomDrawer.of(context)!.close();
                    } else {
                      ZoomDrawer.of(context)!.open();
                    }
                  },
                  child: const SizedBox(
                      height: 24,
                      width: 24,
                      child: SvgPictureAssetWidget(
                          AppAssetImages.menuButtonSVGLogoLine,
                          color: AppColors.mainTextColor)),
                ),
              ),
              actions: [
                Center(
                  child: IconButtonWidget(
                    backgroundColor: AppColors.appBarIconTextColor,
                    onTap: () {
                      Get.toNamed(AppPageNames.notificationScreen,
                          arguments: true);
                    },
                    child: const SizedBox(
                        height: 24,
                        width: 24,
                        child: SvgPictureAssetWidget(
                            AppAssetImages.notificationButtonSVGLogoLine,
                            color: AppColors.mainTextColor)),
                  ),
                ),
                AppGaps.wGap24
              ],
            ),
            body: SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () async => controller.getDashboardInfo(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap16,
                    CustomScaffoldBodyWidget(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              height: 182,
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // AppGaps.hGap16,
                                  Text(
                                    AppLanguageTranslation
                                        .todayTransKey.toCurrentLanguage,
                                    style: AppTextStyles
                                        .titleSemiSmallSemiboldTextStyle,
                                  ),
                                  AppGaps.hGap12,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller
                                            .walletDetails.currency.symbol,
                                        style: AppTextStyles.titleBoldTextStyle
                                            .copyWith(color: Colors.white),
                                      ),
                                      AppGaps.wGap7,
                                      Text(
                                        controller.walletDetails.balance
                                            .toStringAsFixed(2),
                                        style: AppTextStyles.titleBoldTextStyle
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  AppGaps.hGap32,
                                  Container(
                                    height: 1,
                                    color: AppColors.secondarybodyTextColor,
                                  ),
                                  AppGaps.hGap15,
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const SvgPictureAssetWidget(
                                            AppAssetImages.repeatSvgFillIcon,
                                            color: AppColors.mainTextColor,
                                          ),
                                          AppGaps.wGap5,
                                          Text(AppLanguageTranslation
                                              .totalEarningTransKey
                                              .toCurrentLanguage)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SvgPictureAssetWidget(
                                            AppAssetImages.clockFillSvgIcon,
                                            color: AppColors.mainTextColor,
                                          ),
                                          AppGaps.wGap5,
                                          Obx(() => Text(
                                              '${controller.randomTwoDigitNumber.value}h'))
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    AppGaps.hGap24,
                    CustomScaffoldBodyWidget(
                      child: Text(
                        AppLanguageTranslation
                            .earningsTransKey.toCurrentLanguage,
                        style: AppTextStyles.titleSemiSmallBoldTextStyle,
                      ),
                    ),
                    AppGaps.hGap12,
                    CustomScaffoldBodyWidget(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(14),
                                      topRight: Radius.circular(14))),
                              child: controller.earningGraphData.isNotEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                          Row(
                                            children: [
                                              AppGaps.wGap12,
                                              Container(
                                                height: 7,
                                                width: 7,
                                                decoration: const BoxDecoration(
                                                    color: AppColors.rentColor,
                                                    shape: BoxShape.circle),
                                              ),
                                              AppGaps.wGap8,
                                              Text(
                                                AppLanguageTranslation
                                                    .rentTransKey
                                                    .toCurrentLanguage,
                                                style:
                                                    AppTextStyles.bodyTextStyle,
                                              ),
                                              AppGaps.wGap12,
                                              Container(
                                                height: 7,
                                                width: 7,
                                                decoration: const BoxDecoration(
                                                    color: AppColors.rideColor,
                                                    shape: BoxShape.circle),
                                              ),
                                              AppGaps.wGap8,
                                              Text(
                                                AppLanguageTranslation
                                                    .rideTransKey
                                                    .toCurrentLanguage,
                                                style:
                                                    AppTextStyles.bodyTextStyle,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                AppLanguageTranslation
                                                    .lastDaysTransKey
                                                    .toCurrentLanguage,
                                                style: AppTextStyles
                                                    .bodyMediumTextStyle,
                                              ),
                                              AppGaps.wGap25
                                            ],
                                          ),
                                        ])
                                  : AppGaps.emptyGap,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomScaffoldBodyWidget(
                      child: Container(
                        height: 240,
                        decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14))),
                        child: Row(
                          children: [
                            Expanded(
                              child: controller.earningGraphData.isNotEmpty
                                  ? BarChart(BarChartData(
                                      barGroups: controller.earningGraphData
                                          .mapIndexed((i, earning) =>
                                              BarChartGroupData(x: i, barRods: [
                                                BarChartRodData(
                                                  toY: earning.rentCount
                                                      .toDouble(), // Rent count
                                                  width: 10,
                                                  color: AppColors.rideColor,
                                                ),
                                                BarChartRodData(
                                                  toY: earning.rideCount
                                                      .toDouble(), // Ride count
                                                  width: 10,
                                                  color: AppColors.rentColor,
                                                ),
                                              ]))
                                          .toList(),
                                      titlesData: FlTitlesData(
                                          rightTitles: const AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: false,
                                              interval: 500,
                                            ),
                                          ),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (double value,
                                                  TitleMeta meta) {
                                                // Map the x-axis values to days of the week
                                                try {
                                                  final dateTimeValue =
                                                      controller
                                                              .earningGraphData[
                                                          (value.toInt())];
                                                  return Text(dateTimeValue.date
                                                      .formatted('EEE'));
                                                } catch (e) {
                                                  return AppGaps.emptyGap;
                                                }
                                              },
                                            ),
                                          )),
                                      borderData: FlBorderData(show: false),
                                      gridData: const FlGridData(
                                          show: true, drawVerticalLine: false),
                                      barTouchData: BarTouchData(
                                        touchTooltipData: BarTouchTooltipData(
                                          tooltipBorder: const BorderSide(
                                              color: Colors.black),
                                          fitInsideHorizontally: true,
                                          tooltipRoundedRadius: 18,
                                          tooltipBgColor: Colors.white,
                                          getTooltipItem:
                                              controller.getBarTooltipItem,
                                        ),
                                      ),
                                    ))
                                  : Center(
                                      child: EmptyScreenWidget(
                                          height: 80,
                                          isSVGImage: false,
                                          localImageAssetURL:
                                              AppAssetImages.emptyBarImage,
                                          title: AppLanguageTranslation
                                              .noRecordsTransKey
                                              .toCurrentLanguage)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppGaps.hGap24,
                    CustomScaffoldBodyWidget(
                      child: Text(
                        AppLanguageTranslation
                            .carPerformanceTransKey.toCurrentLanguage,
                        style: AppTextStyles.titleSemiSmallBoldTextStyle,
                      ),
                    ),
                    AppGaps.hGap16,
                    CustomScaffoldBodyWidget(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(16),
                                height: 251,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.primaryColor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          AppLanguageTranslation
                                              .carTransKey.toCurrentLanguage,
                                          style: AppTextStyles
                                              .bodyLargeSemiboldTextStyle
                                              .copyWith(color: Colors.white),
                                        ),
                                        AppGaps.wGap15,
                                        Expanded(
                                          child: Builder(builder: (context) {
                                            if (controller.dashboardInfo
                                                .vehicles.isEmpty) {
                                              return AppGaps.emptyGap;
                                            }

                                            return DropdownButton<
                                                DashboardInfoVehicle>(
                                              style: AppTextStyles
                                                  .bodyLargeSemiboldTextStyle
                                                  .copyWith(
                                                      color: Colors.white),
                                              iconEnabledColor: Colors.white,
                                              dropdownColor:
                                                  AppColors.primaryColor,
                                              underline: AppGaps.emptyGap,
                                              value: controller.selectedVehicle,
                                              items: controller
                                                  .dashboardInfo.vehicles
                                                  .map((e) => DropdownMenuItem<
                                                          DashboardInfoVehicle>(
                                                      value: e,
                                                      child:
                                                          Text(e.vehicle.name)))
                                                  .toList(),
                                              onChanged: (value) {
                                                controller.selectedVehicle =
                                                    value;
                                                controller.update();
                                              },
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                        child: controller.selectedVehicle?.stats
                                                    .total !=
                                                0
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                    Expanded(
                                                      child: Stack(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .center,
                                                        children: [
                                                          controller
                                                                      .selectedVehicle
                                                                      ?.stats
                                                                      .total ==
                                                                  0
                                                              ? AppGaps.emptyGap
                                                              : PieChart(
                                                                  swapAnimationCurve:
                                                                      Curves
                                                                          .easeOutSine,
                                                                  swapAnimationDuration:
                                                                      const Duration(
                                                                          seconds:
                                                                              2),
                                                                  PieChartData(
                                                                    startDegreeOffset:
                                                                        340,
                                                                    sectionsSpace:
                                                                        0,
                                                                    centerSpaceRadius:
                                                                        45,
                                                                    sections: /* [
                                                        PieChartSectionData(
                                                          value: 45,
                                                          color: AppColors
                                                              .alertColor,
                                                          radius: 24,
                                                          showTitle: false,
                                                        ),
                                                        PieChartSectionData(
                                                          value: 15,
                                                          color: const Color(
                                                              0xFF3850FB),
                                                          radius: 24,
                                                          showTitle: false,
                                                        ),
                                                        PieChartSectionData(
                                                          value: 40,
                                                          color: const Color(
                                                              0xFFFFD2A3),
                                                          radius: 24,
                                                          showTitle: false,
                                                        ),
                                                      ] */
                                                                        controller.selectedVehicle?.stats.total ==
                                                                                0
                                                                            ? null
                                                                            : [
                                                                                PieChartSectionData(
                                                                                  value: controller.selectedVehicle?.stats.acceptedPiePercentage,
                                                                                  color: const Color(0xFF00C49F),
                                                                                  radius: 24,
                                                                                  showTitle: false,
                                                                                ),
                                                                                PieChartSectionData(
                                                                                  value: controller.selectedVehicle?.stats.completedPiePercentage,
                                                                                  color: const Color(0xFF3850FB),
                                                                                  radius: 24,
                                                                                  showTitle: false,
                                                                                ),
                                                                                PieChartSectionData(
                                                                                  value: controller.selectedVehicle?.stats.cancelledPiePercentage,
                                                                                  color: AppColors.alertColor,
                                                                                  radius: 24,
                                                                                  showTitle: false,
                                                                                ),
                                                                              ],
                                                                  ),
                                                                ),
                                                          Positioned(
                                                              child: Container(
                                                            height: 85,
                                                            width: 85,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .bodyTextColor
                                                                    .withOpacity(
                                                                        0.15),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                // Text("Total Trips",
                                                                Text(
                                                                    AppLanguageTranslation
                                                                        .totalTripsTransKey
                                                                        .toCurrentLanguage,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: AppColors
                                                                            .bodyTextColor)),
                                                                AppGaps.hGap6,
                                                                Text(
                                                                    (controller.selectedVehicle?.stats.total ??
                                                                            0)
                                                                        .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ))
                                                              ],
                                                            ),
                                                          ))
                                                        ],
                                                      ),
                                                    ),
                                                    AppGaps.wGap10,
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          PerformancePercentageWidget(
                                                            // status: 'Completed',
                                                            circleColor:
                                                                const Color(
                                                                    0xFF00C49F),
                                                            status: AppLanguageTranslation
                                                                .acceptedTransKey
                                                                .toCurrentLanguage,
                                                            percentage: (controller
                                                                    .selectedVehicle
                                                                    ?.stats
                                                                    .accepted ??
                                                                0),
                                                          ),
                                                          AppGaps.hGap10,
                                                          AppGaps.hGap10,
                                                          PerformancePercentageWidget(
                                                            circleColor:
                                                                const Color(
                                                                    0xFF3850FB),
                                                            // status: 'Cancelled',
                                                            status: AppLanguageTranslation
                                                                .completedTransKey
                                                                .toCurrentLanguage,
                                                            percentage: (controller
                                                                    .selectedVehicle
                                                                    ?.stats
                                                                    .completed ??
                                                                0),
                                                          ),
                                                          AppGaps.hGap10,
                                                          AppGaps.hGap10,
                                                          PerformancePercentageWidget(
                                                            circleColor:
                                                                AppColors
                                                                    .alertColor,
                                                            // status: 'Rejected',
                                                            status: AppLanguageTranslation
                                                                .rejectedTransKey
                                                                .toCurrentLanguage,
                                                            percentage: (controller
                                                                    .selectedVehicle
                                                                    ?.stats
                                                                    .cancelled ??
                                                                0),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ])
                                            : Center(
                                                child: EmptyScreenWidget(
                                                    isSVGImage: false,
                                                    height: 80,
                                                    localImageAssetURL:
                                                        AppAssetImages
                                                            .emptyPieImage,
                                                    title: AppLanguageTranslation
                                                        .noRecordsTransKey
                                                        .toCurrentLanguage)))
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    AppGaps.hGap24,
                    CustomScaffoldBodyWidget(
                      child: Text(
                        AppLanguageTranslation
                            .serviceReminderTransKey.toCurrentLanguage,
                        style: AppTextStyles.titleSemiSmallBoldTextStyle,
                      ),
                    ),
                    AppGaps.hGap10,
                    /* SizedBox(
                      height: 131,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          ServiceReminderCard card = controller.cards[index];
                          return 
                        },
                        itemCount: controller.cards.length,
                        separatorBuilder: (context, index) => AppGaps.wGap16,
                      ),
                    ), */
                    /* HorizontalListViewBuilderWidget(
                      listViewHeight: 131,
                      separatorBuilderWidget: AppGaps.wGap16,
                      itemCount: controller.cards.length,
                      itemBuilder: (context, index) {
                        ServiceReminderCard card = controller.cards[index];
                        return Container(
                          width: 130,
                          height: 131,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: AppColors.primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: card.iconBackgroundColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: SvgPictureAssetWidget(card.icon),
                                    ),
                                  ),
                                  AppGaps.hGap16,
                                  Text(
                                      card.isShowMoneySymbol
                                          ? Helper
                                              .getCurrencyFormattedWithDecimalAmountText(
                                                  card.count.toDouble())
                                          : card.count.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  AppGaps.hGap10,
                                  Text(card.title,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ))
                                ]),
                          ),
                        );
                      },
                    ), */

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          AppGaps.wGap24,
                          RawButtonWidget(
                            borderRadiusValue: 16,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              width: 130,
                              height: 131,
                              decoration: ShapeDecoration(
                                color: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFF79C39),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    child: const Center(
                                      child: SvgPictureAssetWidget(
                                          color: AppColors.mainTextColor,
                                          AppAssetImages.clockFillSvgIcon),
                                    ),
                                  ),
                                  Text(
                                    '${controller.dashboardInfo.maintenance}',
                                    style: AppTextStyles
                                        .bodyExtraLargeBoldTextStyle
                                        .copyWith(
                                            color: AppColors.mainTextColor),
                                  ),
                                  Text(
                                      AppLanguageTranslation.maintenanceTransKey
                                          .toCurrentLanguage,
                                      style: AppTextStyles.bodyTextStyle
                                          .copyWith(
                                              color: AppColors.mainTextColor)),
                                ],
                              ),
                            ),
                            onTap: () {
                              Get.toNamed(AppPageNames.maintananceScreen);
                            },
                          ),
                          AppGaps.wGap16,
                          RawButtonWidget(
                            borderRadiusValue: 16,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              width: 130,
                              height: 131,
                              decoration: ShapeDecoration(
                                color: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF7A63EB),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    child: const Center(
                                      child: SvgPictureAssetWidget(
                                          color: AppColors.mainTextColor,
                                          AppAssetImages.carSvgFillIcon),
                                    ),
                                  ),
                                  Text(
                                    '${controller.dashboardInfo.fuel}',
                                    style: AppTextStyles
                                        .bodyExtraLargeBoldTextStyle
                                        .copyWith(
                                            color: AppColors.mainTextColor),
                                  ),
                                  Text(
                                      AppLanguageTranslation
                                          .fuelTransKey.toCurrentLanguage,
                                      style: AppTextStyles.bodyTextStyle
                                          .copyWith(
                                              color: AppColors.mainTextColor)),
                                ],
                              ),
                            ),
                            onTap: () {
                              Get.toNamed(
                                  AppPageNames.fuelManagementListScreen);
                            },
                          ),
                        ],
                      ),
                    ),
                    // AppGaps.hGap40,
                    /* const CustomScaffoldBodyWidget(
                      child: Text(
                        'Subscription',
                        style: AppTextStyles.titleSemiSmallBoldTextStyle,
                      ),
                    ),
                    AppGaps.hGap16, */
                    /* CustomScaffoldBodyWidget(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pay Monthly',
                            style: AppTextStyles.bodyLargeMediumTextStyle,
                          ),
                          AppGaps.wGap18,
                          FlutterSwitch(
                            value: controller.toggleNotification.value,
                            width: 35,
                            height: 20,
                            toggleSize: 12,
                            activeColor: AppColors.primaryColor,
                            onToggle: (value) {
                              controller.toggleNotification.value = value;
                              controller.update();
                            },
                          ),
                          AppGaps.wGap18,
                          const Text(
                            'Pay Yearly',
                            style: AppTextStyles.bodyLargeMediumTextStyle,
                          ),
                          AppGaps.wGap7,
                          const SvgPictureAssetWidget(
                              AppAssetImages.linePitchArrowSVGLogoSolid),
                          Text(
                            'Save 10%',
                            style: AppTextStyles.smallestTextStyle
                                .copyWith(color: const Color(0xFF3B82F6)),
                          )
                        ],
                      ),
                    ), */
                    /* AppGaps.hGap26,
                    HorizontalListViewBuilderWidget(
                    listViewHeight: dpi > 420 ? 416 : 316,
                    separatorBuilderWidget: AppGaps.wGap8,
                    itemCount: controller.subscriptionModelItem.length,
                    itemBuilder: (context, index) {
                      final SubscriptionModelItem subscriptionModelItem =
                          controller.subscriptionModelItem[index];
                      return SubscriptionCardWidget(
                        features: subscriptionModelItem.features,
                        isActive: subscriptionModelItem.isActive,
                        rentCarNumber: 2,
                        rentDriverNumber: 5,
                        subscriptionFee: controller.toggleNotification.value
                            ? subscriptionModelItem.price.yearly
                            : subscriptionModelItem.price.monthly,
                        subscriptionPackageType:
                            controller.toggleNotification.value
                                ? 'Yearly'
                                : 'Monthly',
                        subscriptionType: subscriptionModelItem.name,
                        onUpgradeTap: () {
                          Get.toNamed(AppPageNames.upgradeSubscriptionScreen);
                        },
                      );
                    },
                  ), */
                    AppGaps.hGap130,
                  ],
                ),
              ),
            ),
          );
        });
  }
}
