import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:super_tooltip/super_tooltip.dart';

class RentVehicleListItemWidget extends StatelessWidget {
  final String carName;
  final String carNumber;
  final String carImage;
  final bool isRent;
  final bool isRide;
  final bool isActive;
  final void Function(bool) onToggleTap;
  final void Function()? onEditTap;
  final void Function()? onDeletTap;
  final void Function()? onTap;

  const RentVehicleListItemWidget({
    super.key,
    required this.carName,
    required this.carNumber,
    required this.carImage,
    this.isRent = false,
    this.isActive = false,
    this.isRide = false,
    required this.onToggleTap,
    required this.onTap,
    required this.onDeletTap,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        onTap: isActive ? onTap : null,
        hasShadow: true,
        paddingValue: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 85,
              width: 80,
              child: CachedNetworkImageWidget(
                imageURL: carImage,
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
                  carNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyLargeSemiboldTextStyle,
                ),
                AppGaps.hGap6,
                Text(
                  carName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmallTextStyle
                      .copyWith(color: AppColors.bodyTextColor),
                ),
                AppGaps.hGap6,
                AppGaps.hGap6,
              ],
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    AppGaps.wGap15,
                    isActive
                        ? Text(
                            AppLanguageTranslation
                                .activeTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodySmallMediumTextStyle,
                          )
                        : Text(
                            AppLanguageTranslation
                                .inactiveTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodySmallMediumTextStyle),
                    AppGaps.wGap5,
                    SwitchWidget(
                      value: isActive,
                      onToggle: onToggleTap,
                    ),
                    if (!isActive) AppGaps.wGap5,
                    if (!isActive)
                      SuperTooltip(
                        content: Text(
                          AppLanguageTranslation
                              .youCantEditWithoutActiveCarTransKey
                              .toCurrentLanguage,
                          style: AppTextStyles.bodyLargeTextStyle
                              .copyWith(color: AppColors.darkColor),
                        ),
                        child: const SvgPictureAssetWidget(
                          AppAssetImages.infoSVGIcon,
                          color: AppColors.mainTextColor,
                        ),
                      ),
                  ],
                ),
                AppGaps.hGap30,
                isActive
                    ? TightSmallTextButtonWidget(
                        text: AppLanguageTranslation
                            .editTransKey.toCurrentLanguage,
                        textStyle: AppTextStyles.bodyBoldTextStyle.copyWith(
                          color: AppColors.mainTextColor,
                          decoration: TextDecoration.underline,
                        ),
                        onTap: onEditTap,
                      )
                    : RawButtonWidget(
                        onTap: onDeletTap,
                        child: const SvgPictureAssetWidget(
                          AppAssetImages.deletSVGLogoLine,
                          color: AppColors.mainTextColor,
                        ),
                      ),
              ],
            )
          ],
        ));
  }
}
