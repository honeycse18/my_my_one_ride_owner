import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/subscription_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/subscription_model_response.dart';
import 'package:one_ride_car_owner/models/screenParameters/select_screen_parameters.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/subscription_card_widget.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double dpi = MediaQuery.of(context).devicePixelRatio * 160.0;

    return GetBuilder<SubscriptionScreenController>(
        init: SubscriptionScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleWidget: Text(AppLanguageTranslation
                    .subscriptionTransKey.toCurrentLanguage),
              ),
              body: SingleChildScrollView(
                child: Column(children: [
                  AppGaps.hGap26,
                  ScaffoldBodyWidget(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            AppLanguageTranslation
                                .payMonthlyTransKey.toCurrentLanguage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyLargeMediumTextStyle,
                          ),
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
                        Expanded(
                          child: Text(
                            AppLanguageTranslation
                                .payYearlyTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodyLargeMediumTextStyle,
                          ),
                        ),
                        AppGaps.wGap7,
                        const SvgPictureAssetWidget(
                            AppAssetImages.linePitchArrowSVGLogoSolid),
                        Text(
                          '${AppLanguageTranslation.saveTransKey.toCurrentLanguage} 10%',
                          style: AppTextStyles.smallestTextStyle
                              .copyWith(color: const Color(0xFF3B82F6)),
                        )
                      ],
                    ),
                  ),
                  AppGaps.hGap26,

                  /* ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final TopSeller seller =
                                                  controller.topSeller[index];
                                              return SizedBox(
                                                width: 175,
                                                child: TopSellerWidget(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        AppPageNames
                                                            .sellerSingleScreenPage,
                                                        arguments: seller.id);
                                                  },
                                                  name: seller.name,
                                                  status: seller
                                                      .sellerRating.status,
                                                  showStatus: false,
                                                  isVerified: seller.isVerified,
                                                  imageUrl: seller.logo,
                                                  category: seller.category,
                                                  itemCount: seller.products,
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    AppGaps.wGap16,
                                            itemCount:
                                                controller.topSeller.length) */
                  HorizontalListViewBuilderWidget(
                    listViewHeight: dpi > 420 ? 416 : 316,
                    separatorBuilderWidget: AppGaps.wGap8,
                    itemCount: controller.subscriptionModelItem.length,
                    itemBuilder: (context, index) {
                      final SubscriptionModelItem subscriptionModelItem =
                          controller.subscriptionModelItem[index];
                      return SubscriptionCardWidget(
                        features: subscriptionModelItem.features,
                        isActive: subscriptionModelItem.id ==
                            controller
                                .userDetails.subscription.subscriptionName.id,
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
                        onUpgradeTap: () async {
                          await Get.toNamed(
                              AppPageNames.subscriptionPaymentMethodsScreen,
                              arguments: SubsCriptionScreenParameters(
                                  id: subscriptionModelItem.id,
                                  type: controller.toggleNotification.value
                                      ? 'yearly'
                                      : 'monthly'));
                        },
                      );
                    },
                  )
                ]),
              ),
            ));
  }
}
