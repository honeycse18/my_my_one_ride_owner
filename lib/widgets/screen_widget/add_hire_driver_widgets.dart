import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class AddHireDriverListItemWidget extends StatelessWidget {
  final String driverName;

  final String driverImage;
  final String location;
  final int driverExperience;
  final int driverRides;
  final double rate;
  final double rating;

  final void Function()? onTap;
  final void Function()? onhireTap;

  AddHireDriverListItemWidget(
      {super.key,
      required this.driverName,
      required this.location,
      required this.rate,
      required this.rating,
      this.onTap,
      this.onhireTap,
      required this.driverImage,
      required this.driverExperience,
      required this.driverRides});

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        onTap: onTap,
        hasShadow: true,
        paddingValue: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 85,
              width: 85,
              child: CachedNetworkImageWidget(
                imageURL: driverImage,
                imageBuilder: (context, imageProvider) => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: AppComponents.imageBorderRadius,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            AppGaps.wGap12,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driverName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyLargeSemiboldTextStyle,
                ),
                AppGaps.hGap6,
                Row(
                  children: [
                    Text(
                      '$driverExperience ${AppLanguageTranslation.yearsExperienceTransKey.toCurrentLanguage}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmallTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                    AppGaps.wGap8,
                    SingleStarWidget(
                      review: rating,
                    )
                  ],
                ),
                AppGaps.hGap6,
                Row(
                  children: [
                    const SvgPictureAssetWidget(
                      AppAssetImages.locateSVGLogoLine,
                      height: 10,
                      width: 10,
                    ),
                    AppGaps.wGap5,
                    Expanded(
                        child: Text(
                      location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmallMediumTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ))
                  ],
                ),
                AppGaps.hGap6,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Helper.getCurrencyFormattedWithDecimalAmountText(rate),
                      style: AppTextStyles.bodyLargeSemiboldTextStyle,
                    ),
                    AppGaps.wGap8,
                    Text(
                      AppLanguageTranslation.hourlyTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyLargeSemiboldTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                  ],
                )
              ],
            )),
            RawButtonWidget(
                borderRadiusValue: 3,
                onTap: onhireTap,
                child: Container(
                    padding: const EdgeInsets.all(3),
                    width: 40,
                    height: 25,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.mainTextColor),
                        color: AppColors.appBarIconTextColor,
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    child: Center(
                      child: Text(
                        AppLanguageTranslation.hireTimeTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyMediumTextStyle
                            .copyWith(color: Colors.white),
                      ),
                    ))),
            AppGaps.wGap8,
          ],
        ));
  }
}
