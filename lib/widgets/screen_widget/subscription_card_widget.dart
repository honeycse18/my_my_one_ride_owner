import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class SubscriptionCardWidget extends StatelessWidget {
  final String subscriptionType;
  final List<String> features;
  final String subscriptionPackageType;
  final double subscriptionFee;
  final int rentCarNumber;
  final int rentDriverNumber;
  final bool isActive;
  final void Function()? onUpgradeTap;

  const SubscriptionCardWidget({
    super.key,
    required this.subscriptionType,
    required this.subscriptionPackageType,
    required this.subscriptionFee,
    required this.rentCarNumber,
    required this.rentDriverNumber,
    this.isActive = false,
    this.onUpgradeTap,
    required this.features,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subscriptionType,
            style: AppTextStyles.titleBoldTextStyle,
          ),
          AppGaps.hGap16,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                r'$',
                style: AppTextStyles.bodyTextStyle,
              ),
              Text(
                '$subscriptionFee',
                style: AppTextStyles.bodyExtraLargeSemiboldTextStyle,
              ),
              Text(
                '/$subscriptionPackageType',
                style: AppTextStyles.bodyTextStyle
                    .copyWith(color: AppColors.mainTextColor.withOpacity(0.7)),
              )
            ],
          ),
          AppGaps.hGap28,
          AppGaps.hGap28,
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => FeaturesList(
                        featuresName: features[index],
                      ),
                  separatorBuilder: (context, index) => AppGaps.hGap16,
                  itemCount: features.length)),
          /* FeaturesList( 
          ), */
          const Spacer(),
          isActive
              ? Container(
                  height: 48,
                  width: 212,
                  decoration: BoxDecoration(
                      color: AppColors.lightgreenColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: RawButtonWidget(
                    borderRadiusValue: 8,
                    onTap: () {},
                    child: Center(
                        child: Text(
                      AppLanguageTranslation.yourPlanTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyLargeBoldTextStyle
                          .copyWith(color: AppColors.lightgreenColor),
                    )),
                  ),
                )
              : Container(
                  height: 48,
                  width: 212,
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: RawButtonWidget(
                    borderRadiusValue: 8,
                    onTap: onUpgradeTap,
                    child: Center(
                        child: Text(
                      AppLanguageTranslation.getPlanTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyLargeBoldTextStyle
                          .copyWith(color: AppColors.secondaryColor),
                    )),
                  ),
                )
        ],
      ),
    );
  }
}

class FeaturesList extends StatelessWidget {
  final String featuresName;

  const FeaturesList({
    super.key,
    required this.featuresName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SvgPictureAssetWidget(
          AppAssetImages.tickIconSVG,
          height: 10,
          width: 10,
          color: AppColors.mainTextColor,
        ),
        AppGaps.wGap15,
        Expanded(
          child: Text(featuresName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyLargeTextStyle),
        )
      ],
    );
  }
}
