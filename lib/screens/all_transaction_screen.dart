import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/all_transaction_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/wallet_history_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/transaction_widget.dart';

class AllTransactionScreen extends StatelessWidget {
  const AllTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllTransactionScreenScreenController>(
        init: AllTransactionScreenScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleWidget: Text(AppLanguageTranslation
                    .updateVehiclesTransKey.toCurrentLanguage),
              ),
              body: ScaffoldBodyWidget(
                  child: RefreshIndicator(
                onRefresh: () async =>
                    controller.transactionHistoryPagingController.refresh(),
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap10,
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        AppLanguageTranslation
                            .transactionTransKey.toCurrentLanguage,
                        style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap20,
                    ),
                    PagedSliverList.separated(
                      pagingController:
                          controller.transactionHistoryPagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<TransactionHistoryItems>(
                              noItemsFoundIndicatorBuilder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            EmptyScreenWidget(
                                //-----------------------
                                localImageAssetURL:
                                    AppAssetImages.confirmIconImage,
                                title: AppLanguageTranslation
                                    .noTransactionTransKey.toCurrentLanguage,
                                shortTitle: '')
                          ],
                        );
                      }, itemBuilder: (context, item, index) {
                        final TransactionHistoryItems transactionHistoryList =
                            item;
                        return TransactionWidget(
                          symbol: controller.symbol,
                          isEarned: transactionHistoryList.type == 'add_money'
                              ? true
                              : false,
                          amount: transactionHistoryList.amount,
                          date: DateTime.now(),
                          time: DateTime.now(),
                          transactionName: transactionHistoryList.type,
                          transactionType: transactionHistoryList.method,
                        );
                      }),
                      separatorBuilder: (context, index) => AppGaps.hGap16,
                    )
                  ],
                ),
              )),
            ));
  }
}
