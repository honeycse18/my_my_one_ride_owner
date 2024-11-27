import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class FuelManagementListWidget extends StatelessWidget {
  final String carImage;

  final int quantity;
  final String carName;
  final String carCategoryName;
  final String carCostBear;
  final String status;
  final double cost;
  final DateTime fillDate;
  final DateTime endDate;
  final int startKm;
  final void Function(String)? onSelected;

  const FuelManagementListWidget({
    super.key,
    required this.carImage,
    required this.carName,
    required this.carCategoryName,
    required this.carCostBear,
    required this.cost,
    required this.fillDate,
    required this.startKm,
    required this.quantity,
    required this.status,
    required this.endDate,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 156,
            decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: Column(children: [
              Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
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
                        carName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyLargeSemiboldTextStyle,
                      ),
                      AppGaps.hGap8,
                      Text(carCategoryName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmallTextStyle.copyWith(
                            color: AppColors.mainTextColor,
                          )),
                      AppGaps.hGap8,
                      Row(
                        children: [
                          Text(
                              AppLanguageTranslation
                                  .costBearByTransKey.toCurrentLanguage,
                              style: AppTextStyles.bodySmallTextStyle.copyWith(
                                color: AppColors.mainTextColor,
                              )),
                          AppGaps.wGap4,
                          Text(carCostBear.toUpperCase(),
                              style: AppTextStyles.bodyBoldTextStyle.copyWith(
                                color: AppColors.mainTextColor,
                              )),
                        ],
                      ),
                    ],
                  )),
                  if (status != 'complete')
                    PopupMenuButton<String>(
                      icon: const SvgPictureAssetWidget(
                        AppAssetImages.editSVGLogoLine,
                        color: AppColors.mainTextColor,
                        height: 30,
                        width: 30,
                      ),
                      initialValue: null,
                      // Callback that sets the selected popup menu item.
                      onSelected: onSelected,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Edit',
                          child: Text(
                            AppLanguageTranslation
                                .editTransKey.toCurrentLanguage,
                            style: TextStyle(color: AppColors.mainTextColor),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'Complete',
                          child: Text(
                              AppLanguageTranslation
                                  .completeTransKey.toCurrentLanguage,
                              style: TextStyle(color: AppColors.mainTextColor)),
                        ),
                        PopupMenuItem<String>(
                          value: 'Delete',
                          child: Text(
                              AppLanguageTranslation
                                  .deleteTransKey.toCurrentLanguage,
                              style: TextStyle(color: AppColors.mainTextColor)),
                        ),
                      ],
                    ),
                ],
              ),
              AppGaps.hGap10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        AppLanguageTranslation
                            .quantityTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      Text(
                        '$quantity gallon',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyBoldTextStyle
                            .copyWith(color: AppColors.mainTextColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        AppLanguageTranslation
                            .costColonTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      Text(
                        Helper.getCurrencyFormattedWithDecimalAmountText(cost),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyBoldTextStyle
                            .copyWith(color: AppColors.mainTextColor),
                      ),
                    ],
                  ),
                ],
              ),
              AppGaps.hGap10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        AppLanguageTranslation
                            .fillDateTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      AppGaps.wGap5,
                      Text(
                        Helper.ddMMMyyyyFormattedDateTime(fillDate),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyBoldTextStyle
                            .copyWith(color: AppColors.mainTextColor),
                      ),
                    ],
                  ),
                  status == 'complete'
                      ? Row(
                          children: [
                            Text(
                              AppLanguageTranslation
                                  .endDateTransKey.toCurrentLanguage,
                              style: AppTextStyles.bodyTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                            AppGaps.wGap5,
                            Text(
                              Helper.ddMMMyyyyFormattedDateTime(endDate),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyBoldTextStyle
                                  .copyWith(color: AppColors.mainTextColor),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              AppLanguageTranslation
                                  .startedMeterTransKey.toCurrentLanguage,
                              style: AppTextStyles.bodyTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                            AppGaps.wGap5,
                            Text(
                              '$startKm',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyBoldTextStyle
                                  .copyWith(color: AppColors.mainTextColor),
                            ),
                          ],
                        ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
