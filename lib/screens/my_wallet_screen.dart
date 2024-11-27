import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/my_wallet_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/wallet_history_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/transaction_widget.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWalletScreenScreenController>(
        init: MyWalletScreenScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: false,
                titleWidget:  Text(
                  AppLanguageTranslation.walletTransKey.toCurrentLanguage,
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
              /* appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              titleWidget: const Text('My Wallet'),
              actions: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 24, 5),
                  height: 40,
                  width: 81,
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: RawButtonWidget(
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SvgPictureAssetWidget(
                          AppAssetImages.dollerSVGLogoSolid,
                          color: Colors.white,
                        ),
                        Text(
                          'TopUp',
                          style: AppTextStyles.bodyMediumTextStyle
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    )),
                    onTap: () {
                      Get.toNamed(AppPageNames.topupScreen);
                    },
                  ),
                )
              ]), */
              body: SafeArea(
                child: ScaffoldBodyWidget(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.getWalletDetails();
                      controller.update();
                    },
                    child: Column(
                      children: [
                        AppGaps.hGap24,
                        /* Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(12, 0, 8, 0),
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFFEF3E6)),
                                  child: const Center(
                                    child: SvgPictureAssetWidget(
                                        AppAssetImages
                                            .dollerCountSVGLogoSolid),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(r'$500',
                                        style: AppTextStyles
                                            .titleSemiboldTextStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryColor)),
                                    Text(
                                      'Available Balance',
                                      style: AppTextStyles.bodyTextStyle
                                          .copyWith(
                                              color: AppColors.bodyTextColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        AppGaps.wGap16,
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(12, 0, 8, 0),
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFEFF6FF)),
                                  child: const Center(
                                    child: SvgPictureAssetWidget(
                                        AppAssetImages
                                            .dollerSendSVGLogoSolid),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(r'$500',
                                        style: AppTextStyles
                                            .titleSemiboldTextStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryColor)),
                                    Text(
                                      'Total Expend',
                                      style: AppTextStyles.bodyTextStyle
                                          .copyWith(
                                              color: AppColors.bodyTextColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ), */
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 164,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(14)),
                                image: DecorationImage(
                                    image: Image.asset(
                                      AppAssetImages.walletBackImage,
                                    ).image,
                                    fit: BoxFit.fill),
                              ),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                  AppGaps.hGap10,
                                  Text(
                                    'Your Wallet Balance',
                                    style: AppTextStyles
                                        .notificationSemiBoldDateSection
                                        .copyWith(color: Colors.white),
                                  ),
                                  AppGaps.hGap24,
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        height: 1,
                                        color: Colors.white,
                                      ))
                                    ],
                                  ),
                                  AppGaps.hGap18,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          const SvgPictureAssetWidget(
                                            AppAssetImages.repeatSVGLogoLine,
                                            color: Colors.white,
                                          ),
                                          AppGaps.wGap8,
                                          Text(
                                            'Today Earning',
                                            style: AppTextStyles
                                                .bodyBoldTextStyle
                                                .copyWith(color: Colors.white),
                                          )
                                        ],
                                      ),
                                      AppGaps.wGap20,
                                      Text(
                                        r'$50000',
                                        style: AppTextStyles
                                            .bodySemiboldTextStyle
                                            .copyWith(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                            ))
                          ],
                        ),
                        AppGaps.hGap12,
                        Row(
                          children: [
                            /*  Expanded(
                              child: CustomStretchedOutlinedButtonWidget(
                                child: Text(
                                  '+ Top-Up',
                                  style: AppTextStyles
                                      .bodyLargeSemiboldTextStyle
                                      .copyWith(color: AppColors.mainTextColor),
                                ),
                                onTap: () async {
                                  await Get.toNamed(AppPageNames.topupScreen);
                                  controller.getWalletDetails();
                                  controller.update();
                                },
                              ),
                            ),
                            AppGaps.wGap16, */
                            Expanded(
                              child: CustomStretchedTextButtonWidget(
                                buttonText: '+ Top-Up',
                                onTap: () async {
                                  await Get.toNamed(AppPageNames.topupScreen);
                                  controller.getWalletDetails();
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ),
                        AppGaps.hGap24,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Transaction',
                              style:
                                  AppTextStyles.titleSemiSmallSemiboldTextStyle,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(AppPageNames.allTransactionScreen,
                                      arguments: controller
                                          .walletDetails.currency.symbol);
                                },
                                child: Text(
                                  'See All',
                                  style: AppTextStyles.bodyTextStyle
                                      .copyWith(color: AppColors.mainTextColor),
                                ))
                          ],
                        ),
                        AppGaps.hGap15,
                        Expanded(
                            child: RefreshIndicator(
                          onRefresh: () async => controller
                              .transactionHistoryPagingController
                              .refresh(),
                          child: CustomScrollView(
                            slivers: [
                              PagedSliverList.separated(
                                pagingController: controller
                                    .transactionHistoryPagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                        TransactionHistoryItems>(
                                    noItemsFoundIndicatorBuilder: (context) {
                                  return const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      EmptyScreenWidget(
                                          //-----------------------
                                          localImageAssetURL:
                                              AppAssetImages.confirmIconImage,
                                          title: 'No Transaction History',
                                          shortTitle: '')
                                    ],
                                  );
                                }, itemBuilder: (context, item, index) {
                                  final TransactionHistoryItems
                                      transactionHistoryList = item;
                                  return TransactionWidget(
                                    symbol: controller
                                        .walletDetails.currency.symbol,
                                    isEarned: transactionHistoryList.type ==
                                            'add_money'
                                        ? true
                                        : false,
                                    amount: transactionHistoryList.amount,
                                    date: DateTime.now(),
                                    time: DateTime.now(),
                                    transactionName:
                                        transactionHistoryList.type,
                                    transactionType:
                                        transactionHistoryList.method,
                                  );
                                }),
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16,
                              )
                            ],
                          ),
                        )

                            /* ListView.separated(
                              padding: EdgeInsets.only(bottom: 35),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                /* return TransactionWidget(
                                  isEarned: false,
                                  amount: 16.0,
                                  date: DateTime.now(),
                                  time: DateTime.now(),
                                  transactionName: 'TopUp Tomney',
                                  transactionType: 'Expendad',
                                ); */
                              },
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                              itemCount: 20), */
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
