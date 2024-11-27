import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class MySubscriptionCardWidget extends StatelessWidget {
  final String subscriptionType;
  final String subsUid;
  final String status;
  final String subscriptionPackageName;
  final DateTime expireDate;
  final int vehicleAdd;
  final bool isFleet;

  const MySubscriptionCardWidget({
    super.key,
    required this.subscriptionType,
    required this.subscriptionPackageName,
    required this.status,
    required this.vehicleAdd,
    required this.isFleet,
    required this.expireDate,
    required this.subsUid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 416,
      width: 260,
      decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppLanguageTranslation.packageNameTransKey.toCurrentLanguage,
                style: AppTextStyles.bodyLargeTextStyle,
              ),
            ),
          ],
        ),
        AppGaps.hGap14,
        Row(
          children: [
            Expanded(
              child: Text(
                subscriptionPackageName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: AppTextStyles.titleLargeBoldTextStyle,
              ),
            ),
          ],
        ),
        AppGaps.hGap34,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLanguageTranslation.uidTransKey.toCurrentLanguage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeTextStyle,
                  ),
                  const Text(
                    ':',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeTextStyle,
                  ),
                ],
              ),
            ),
            AppGaps.wGap10,
            Expanded(
                child: Text(
              subsUid.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyLargeSemiboldTextStyle,
            ))
          ],
        ),
        AppGaps.hGap14,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLanguageTranslation
                        .packageTypeTransKey.toCurrentLanguage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeTextStyle,
                  ),
                  const Text(
                    ':',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeTextStyle,
                  ),
                ],
              ),
            ),
            AppGaps.wGap10,
            Expanded(
                child: Text(
              subscriptionType.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyLargeSemiboldTextStyle,
            ))
          ],
        ),
        AppGaps.hGap14,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLanguageTranslation.expireDateTransKey.toCurrentLanguage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeTextStyle,
                  ),
                  const Text(
                    ':',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeTextStyle,
                  ),
                ],
              ),
            ),
            AppGaps.wGap10,
            Expanded(
                child: Text(
              Helper.ddmmyyyyhhmmFormattedDateTime(expireDate),
              maxLines: 2,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyLargeSemiboldTextStyle,
            ))
          ],
        ),
        AppGaps.hGap34,
        Row(
          children: [
            const SvgPictureAssetWidget(
              AppAssetImages.tickIconSVG,
              color: AppColors.mainTextColor,
              height: 8,
              width: 8,
            ),
            AppGaps.wGap20,
            Expanded(
                child: Text(
              '${AppLanguageTranslation.uploadTransKey.toCurrentLanguage}   $vehicleAdd  ${AppLanguageTranslation.carForRentTransKey.toCurrentLanguage}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyLargeTextStyle,
            ))
          ],
        ),
        AppGaps.hGap24,
        if (isFleet)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SvgPictureAssetWidget(
                AppAssetImages.tickIconSVG,
                color: AppColors.mainTextColor,
                height: 8,
                width: 8,
              ),
              AppGaps.wGap20,
              Expanded(
                  child: Text(
                AppLanguageTranslation.canSeeTransKey.toCurrentLanguage,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyLargeTextStyle,
              ))
            ],
          ),
        if (!isFleet) AppGaps.hGap35,
        const Spacer(),
        status == 'Active'
            ? Expanded(
                child: SizedBox(
                  height: 48,
                  width: 112,
                  /* decoration: BoxDecoration(
                      color: AppColors.lightgreenColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(8))), */
                  child: Center(
                      child: Text(
                    AppLanguageTranslation.activeTransKey.toCurrentLanguage,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyLargeBoldTextStyle
                        .copyWith(color: AppColors.lightgreenColor),
                  )),
                ),
              )
            : status == 'Upcoming'
                ? Expanded(
                    child: SizedBox(
                      height: 48,
                      width: 112,
                      /* decoration: BoxDecoration(
                          color: AppColors.secondaryColor.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))), */
                      child: Center(
                          child: Text(
                        AppLanguageTranslation
                            .upcomingTransKey.toCurrentLanguage,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLargeBoldTextStyle
                            .copyWith(color: AppColors.secondaryColor),
                      )),
                    ),
                  )
                : Expanded(
                    child: SizedBox(
                      height: 48,
                      width: 212,
                      /* decoration: BoxDecoration(
                          color: AppColors.alertColor.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))), */
                      child: Center(
                          child: Text(
                        AppLanguageTranslation
                            .expiredTransKey.toCurrentLanguage,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLargeBoldTextStyle
                            .copyWith(color: AppColors.alertColor),
                      )),
                    ),
                  )
      ]),
    );
  }
}
