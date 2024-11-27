import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/my_subscriptions_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/my_subscription_list_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/my_subscription_card_widget.dart';

class MySubscriptionsScreen extends StatelessWidget {
  const MySubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double dpi = MediaQuery.of(context).devicePixelRatio * 160.0;

    return GetBuilder<MySubscriptionsScreenController>(
        init: MySubscriptionsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleWidget: Text(AppLanguageTranslation
                    .mySubscriptionsTransKey.toCurrentLanguage),
              ),
              body: Column(
                children: [
                  AppGaps.hGap20,
                  controller.mySubscriptionsModelItem.isNotEmpty
                      ? HorizontalListViewBuilderWidget(
                          listViewHeight: dpi > 420 ? 436 : 426,
                          separatorBuilderWidget: AppGaps.wGap20,
                          itemCount: controller.mySubscriptionsModelItem.length,
                          itemBuilder: (context, index) {
                            final MySubscriptionItem subscriptionModelItem =
                                controller.mySubscriptionsModelItem[index];
                            return MySubscriptionCardWidget(
                              subsUid: subscriptionModelItem.uid,
                              expireDate: subscriptionModelItem.endDate,
                              vehicleAdd: subscriptionModelItem.vehicles,
                              subscriptionPackageName:
                                  subscriptionModelItem.subscription.name,
                              isFleet: subscriptionModelItem.isFleet,
                              status: subscriptionModelItem.status,
                              subscriptionType: subscriptionModelItem.type,
                            );
                          },
                        )
                      : const Center(
                          child: EmptyScreenWidget(
                              localImageAssetURL: AppAssetImages.nuSubLogoAlert,
                              height: 150,
                              title: 'You Have No Subscription'),
                        )
                ],
              ),
            ));
  }
}
