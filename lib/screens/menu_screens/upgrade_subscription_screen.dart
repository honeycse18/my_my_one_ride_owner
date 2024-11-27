/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/upgrade_subscription_screen_controller.dart';
import 'package:one_ride_car_owner/models/fakeModel/fake_data.dart';
import 'package:one_ride_car_owner/models/fakeModel/payment_option_model.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/payment_screen_widget.dart';

class UpgradeSubscriptionScreen extends StatelessWidget {
  const UpgradeSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpgradeSubscriptionScreenController>(
        init: UpgradeSubscriptionScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: const Text('Subscription')),
              body: ScaffoldBodyWidget(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap12,
                    const Text(
                      'Details',
                      style: AppTextStyles.titleSemiSmallBoldTextStyle,
                    ),
                    AppGaps.hGap12,
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            height: 80,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Premium plan',
                                          style: AppTextStyles
                                              .bodyMediumTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.bodyTextColor),
                                        ),
                                        controller.selectedValue.value ==
                                                'monthly'
                                            ? const Text(
                                                'Monthly Subscription',
                                                style: AppTextStyles
                                                    .bodyLargeSemiboldTextStyle,
                                              )
                                            : const Text(
                                                'Yearly Subscription',
                                                style: AppTextStyles
                                                    .bodyLargeSemiboldTextStyle,
                                              )
                                      ],
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Obx(() {
                                          return SizedBox(
                                            height: 17,
                                            child: DropdownButton<String>(
                                              value: controller
                                                  .selectedValue.value,
                                              isDense: true,
                                              icon: const SvgPictureAssetWidget(
                                                AppAssetImages
                                                    .arrowDownSVGLogoLine,
                                                height: 6,
                                                width: 12,
                                                color: AppColors.primaryColor,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(14)),
                                              underline: AppGaps.emptyGap,
                                              items: [
                                                DropdownMenuItem(
                                                    value: 'monthly',
                                                    child: Text(
                                                      'Pay Monthly ',
                                                      style: AppTextStyles
                                                          .bodyMediumTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryColor),
                                                    )),
                                                DropdownMenuItem(
                                                    value: 'yearly',
                                                    child: Text(
                                                      'Pay Yearly',
                                                      style: AppTextStyles
                                                          .bodyMediumTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryColor),
                                                    )),
                                              ],
                                              onChanged: (newValue) {
                                                controller.updateSelectedValue(
                                                    newValue.toString());
                                              },
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                    Obx(() => Row(
                                          children: [
                                            controller.selectedValue.value ==
                                                    'monthly'
                                                ? Text(
                                                    Helper
                                                        .getCurrencyFormattedWithDecimalAmountText(
                                                            50),
                                                    style: AppTextStyles
                                                        .bodyLargeSemiboldTextStyle,
                                                  )
                                                : Text(
                                                    Helper
                                                        .getCurrencyFormattedWithDecimalAmountText(
                                                            123),
                                                    style: AppTextStyles
                                                        .bodyLargeSemiboldTextStyle,
                                                  )
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    AppGaps.hGap24,
                    const Text(
                      'Select Top Up Method',
                      style: AppTextStyles.titleSemiSmallBoldTextStyle,
                    ),
                    AppGaps.hGap12,
                    SizedBox(
                      height: 500,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            FakePaymentOptionModel paymentOption =
                                FakeData.paymentOptions[index];
                            return PaymentOptionListTileWidget(
                              hasShadow: true,
                              id: paymentOption.id,
                              paymentImageURL: paymentOption.paymentImage,
                              paymentName: paymentOption.name,
                              radioOnChange: (value) =>
                                  controller.onWithdrawRadioChange('monthly'),
                              selectedPaymentOptionId: paymentOption.id,
                            );
                          },
                          separatorBuilder: (context, index) => AppGaps.hGap12,
                          itemCount: FakeData.paymentOptions.length),
                    )
                  ],
                ),
              )),
              bottomNavigationBar: ScaffoldBodyWidget(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total ',
                        style: AppTextStyles.bodyExtraLargeSemiboldTextStyle,
                      ),
                      Obx(() => controller.selectedValue.value == 'monthly'
                          ? Text(
                              Helper.getCurrencyFormattedWithDecimalAmountText(
                                  50),
                              style:
                                  AppTextStyles.bodyExtraLargeSemiboldTextStyle,
                            )
                          : Text(
                              Helper.getCurrencyFormattedWithDecimalAmountText(
                                  123),
                              style:
                                  AppTextStyles.bodyExtraLargeSemiboldTextStyle,
                            ))
                    ],
                  ),
                  AppGaps.hGap16,
                  StretchedTextButtonWidget(
                    color: AppColors.primaryColor,
                    buttonText: 'Confirm and Pay',
                    onTap: () {},
                  ),
                  AppGaps.hGap10,
                ],
              )),
            ));
  }
}
 */
