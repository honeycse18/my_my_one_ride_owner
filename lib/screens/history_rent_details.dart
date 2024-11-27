import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/home_navigator/rent_history_details_screen_controller.dart';
import 'package:one_ride_car_owner/screens/bottom_sheet/submit_otp_screen_bottomsheet.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class HistoryRentDetailsScreen extends StatelessWidget {
  const HistoryRentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RentDetailsScreenController>(
        init: RentDetailsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .rentDetailsTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap24,
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          height: 87,
                          decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: CachedNetworkImageWidget(
                                  imageURL:
                                      controller.historyDetails.user.image,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                              AppGaps.wGap8,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.historyDetails.user.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles
                                          .bodyLargeSemiboldTextStyle,
                                    ),
                                    AppGaps.hGap5,
                                    Row(
                                      children: [
                                        //need api
                                        SingleStarWidget(review: 2),
                                        Text(
                                          '(531 reviews)',
                                          style: AppTextStyles.captionTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.bodyTextColor),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              AppGaps.wGap8,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      Helper
                                          .getCurrencyFormattedWithDecimalAmountText(
                                              controller.historyDetails.total),
                                      style: AppTextStyles
                                          .bodyLargeSemiboldTextStyle,
                                    ),
                                    AppGaps.hGap8,
                                    controller.historyDetails.type == 'hourly'
                                        ? Text(
                                            '${controller.historyDetails.quantity} ${AppLanguageTranslation.hourTransKey.toCurrentLanguage}',
                                            style: AppTextStyles
                                                .captionTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .bodyTextColor))
                                        : controller.historyDetails.type ==
                                                'weekly'
                                            ? Text(
                                                '${controller.historyDetails.quantity} ${AppLanguageTranslation.weekTransKey.toCurrentLanguage}',
                                                style: AppTextStyles
                                                    .captionTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .bodyTextColor))
                                            : Text(
                                                '${controller.historyDetails.quantity} ${AppLanguageTranslation.monthTransKey.toCurrentLanguage}',
                                                style: AppTextStyles
                                                    .captionTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .bodyTextColor))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                    AppGaps.hGap16,
                    Row(
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              border: Border.all(
                                  color: AppColors.primaryBorderColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          child: const Center(
                              child: RawButtonWidget(
                                  child: SvgPictureAssetWidget(
                                      AppAssetImages.callSvgFillIcon))),
                        ),
                        AppGaps.wGap8,
                        Expanded(
                            child: CustomMessageTextFormField(
                          onTap: () {
                            Get.toNamed(AppPageNames.chatScreen,
                                arguments: controller.historyDetails.user.id);
                          },
                          isReadOnly: true,
                          suffixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.sendSVGLogoLine),
                          boxHeight: 55,
                          hintText: AppLanguageTranslation
                              .messageYourDriverTransKey.toCurrentLanguage,
                        ))
                      ],
                    ),
                    AppGaps.hGap24,
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(16),
                          height: 57,
                          decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                    AppLanguageTranslation.startDateTimeTransKey
                                        .toCurrentLanguage,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.bodyLargeTextStyle
                                        .copyWith(
                                            color: AppColors.bodyTextColor)),
                              ),
                              Text(
                                  Helper.ddmmyyyyhhmmFormattedDateTime(
                                      controller.historyDetails.date),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      AppTextStyles.bodyLargeMediumTextStyle),
                            ],
                          ),
                        ))
                      ],
                    ),
                    AppGaps.hGap31,
                    controller.historyDetails.driver.id.isNotEmpty
                        ?  Text(
                            AppLanguageTranslation.driverTransKey.toCurrentLanguage,
                            style:
                                AppTextStyles.bodyExtraLargeSemiboldTextStyle,
                          )
                        : AppGaps.emptyGap,
                    if (controller.historyDetails.driver.id.isNotEmpty)
                      AppGaps.hGap16,
                    if (controller.historyDetails.driver.id.isNotEmpty)
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.all(20),
                            height: 87,
                            decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CachedNetworkImageWidget(
                                    imageURL:
                                        controller.historyDetails.driver.image,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                                AppGaps.wGap8,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.historyDetails.driver.name,
                                        style: AppTextStyles
                                            .bodyLargeSemiboldTextStyle,
                                      ),
                                      AppGaps.hGap5,
                                      Row(
                                        children: [
                                          //need api
                                          SingleStarWidget(review: 2),
                                          Text(
                                            '(121 reviews)',
                                            style: AppTextStyles
                                                .captionTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                RawButtonWidget(
                                  borderRadiusValue: 12,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        border: Border.all(
                                            color:
                                                AppColors.primaryBorderColor),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12))),
                                    child: const Center(
                                        child: SvgPictureAssetWidget(
                                            AppAssetImages.chatMeSVGLogoLine)),
                                  ),
                                  onTap: () {
                                    Get.toNamed(AppPageNames.chatScreen,
                                        arguments: controller
                                            .historyDetails.driver.id);
                                  },
                                ),
                                AppGaps.wGap8,
                                RawButtonWidget(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        border: Border.all(
                                            color:
                                                AppColors.primaryBorderColor),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12))),
                                    child: const Center(
                                        child: RawButtonWidget(
                                            child: SvgPictureAssetWidget(
                                                AppAssetImages
                                                    .callSvgFillIcon))),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    AppGaps.hGap24,
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            height: 160,
                            decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    AppLanguageTranslation.billingDetailsTransKey
                                        .toCurrentLanguage,
                                    style: AppTextStyles
                                        .titleSemiSmallSemiboldTextStyle,
                                  ),
                                  AppGaps.hGap8,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLanguageTranslation.totalFareTransKey
                                            .toCurrentLanguage,
                                        style: AppTextStyles.bodyLargeTextStyle
                                            .copyWith(
                                                color: AppColors.bodyTextColor),
                                      ),
                                      Text(
                                        Helper
                                            .getCurrencyFormattedWithDecimalAmountText(
                                                controller
                                                    .historyDetails.total),
                                        style: AppTextStyles
                                            .bodyLargeMediumTextStyle,
                                      )
                                    ],
                                  ),
                                  AppGaps.hGap8,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLanguageTranslation.discountTransKey.toCurrentLanguage,
                                        style: AppTextStyles.bodyLargeTextStyle
                                            .copyWith(
                                                color: AppColors.alertColor),
                                      ),
                                      Text(
                                        Helper
                                            .getCurrencyFormattedWithDecimalAmountText(
                                                controller
                                                        .historyDetails.total -
                                                    controller
                                                        .historyDetails.total),
                                        style: AppTextStyles
                                            .bodyLargeMediumTextStyle
                                            .copyWith(
                                                color: AppColors.alertColor),
                                      )
                                    ],
                                  ),
                                  AppGaps.hGap15,
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        height: 1,
                                        color: Colors.grey.withOpacity(0.2),
                                      ))
                                    ],
                                  ),
                                  AppGaps.hGap8,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                       Text(
                                       AppLanguageTranslation.totalFareTransKey.toCurrentLanguage,
                                        style: AppTextStyles
                                            .bodyLargeSemiboldTextStyle,
                                      ),
                                      Text(
                                        Helper
                                            .getCurrencyFormattedWithDecimalAmountText(
                                                controller
                                                    .historyDetails.total),
                                        style: AppTextStyles
                                            .bodyLargeSemiboldTextStyle,
                                      )
                                    ],
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(14),
                          height: 47,
                          decoration: BoxDecoration(
                              color: AppColors.mainTextColor.withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(14),
                                  bottomRight: Radius.circular(14))),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text(
                                AppLanguageTranslation.paymentModeTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodyTextStyle,
                              ),
                              Text(
                                controller.historyDetails.paymentMethod
                                    .toUpperCase(),
                                style: AppTextStyles.bodyTextStyle,
                              ),
                            ],
                          )),
                        ))
                      ],
                    )
                  ],
                ),
              )),
              bottomNavigationBar: ScaffoldBodyWidget(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  controller.historyDetails.status == 'accepted'
                      ? Row(
                          children: [
                            Expanded(
                              child: CustomStretcheOutlinedButtonWidget(
                                child:  Text(
                                  AppLanguageTranslation.cancelTripTransKey.toCurrentLanguage,
                                  style:
                                      TextStyle(color: AppColors.mainTextColor),
                                ),
                                onTap: () => controller.cancelRentStatus(
                                    controller.historyDetails.id, 'cancelled'),
                              ),
                            ),
                            AppGaps.wGap10,
                            Expanded(
                              child: CustomStretchedButtonWidget(
                                  child:  Text(AppLanguageTranslation.startTripTransKey.toCurrentLanguage),
                                  onTap: () {
                                    /* controller.startPostRentStatus(
                                      controller.historyDetails.id, 'started'); */
                                    Get.bottomSheet(
                                        SubmitOtpStartRideBottomSheet(),
                                        settings: RouteSettings(
                                            arguments:
                                                controller.historyDetails.id));
                                  }),
                            ),
                          ],
                        )
                      : controller.historyDetails.status == 'started'
                          ? CustomStretchedButtonWidget(
                              child:  Text(AppLanguageTranslation.completedTripTransKey.toCurrentLanguage),
                              onTap: () => controller.startPostRentStatus(
                                  controller.historyDetails.id, 'completed'),
                            )
                          : controller.historyDetails.status == 'cancelled'
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLanguageTranslation.cancelReasonTransKey
                                          .toCurrentLanguage,
                                      style: AppTextStyles
                                          .bodyLargeSemiboldTextStyle
                                          .copyWith(color: Colors.red),
                                    ),
                                    AppGaps.wGap15,
                                    Text(
                                      controller.historyDetails.cancelReason,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles
                                          .bodyLargeSemiboldTextStyle
                                          .copyWith(color: Colors.red),
                                    ),
                                  ],
                                )
                              : AppGaps.emptyGap,
                  AppGaps.hGap10,
                ],
              )),
            ));
  }
}
