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

class MaintenanceManagementListWidget extends StatelessWidget {
  final String carImage;
  final String carName;
  final String carCategoryName;
  final String carCostBear;
  final String status;
  final List<String> parts;
  final double cost;
  final DateTime date;
  final void Function(String)? onSelected;

  const MaintenanceManagementListWidget({
    super.key,
    required this.carImage,
    required this.carName,
    required this.carCategoryName,
    required this.carCostBear,
    required this.cost,
    required this.parts,
    required this.date,
    required this.status,
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
                          Text('Cost Bear By:',
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
                        height: 30,
                        width: 30,
                        color: AppColors.bodyTextColor,
                      ),
                      initialValue: null,
                      // Callback that sets the selected popup menu item.
                      onSelected: onSelected,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Edit',
                          textStyle: AppTextStyles.bodyTextStyle
                              .copyWith(color: Colors.white),
                          child: Text(AppLanguageTranslation
                              .editTransKey.toCurrentLanguage),
                        ),
                        PopupMenuItem<String>(
                          value: 'Complete',
                          textStyle: AppTextStyles.bodyTextStyle
                              .copyWith(color: Colors.white),
                          child: Text(AppLanguageTranslation
                              .completeTransKey.toCurrentLanguage),
                        ),
                        PopupMenuItem<String>(
                          value: 'Delete',
                          textStyle: AppTextStyles.bodyTextStyle
                              .copyWith(color: Colors.white),
                          child: Text(AppLanguageTranslation
                              .deleteTransKey.toCurrentLanguage),
                        ),
                      ],
                    ),
                ],
              ),
              AppGaps.hGap10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          AppLanguageTranslation
                              .partsNameTransKey.toCurrentLanguage,
                          style: AppTextStyles.bodyTextStyle
                              .copyWith(color: AppColors.bodyTextColor),
                        ),
                        AppGaps
                            .wGap5, // Spacer between texts, you can use AppGaps.wGap5 if available
                        Expanded(
                          child: Text(
                            parts.join(', '),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyBoldTextStyle
                                .copyWith(color: AppColors.mainTextColor),
                          ),
                        )
                      ],
                    ),
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
                            .startDateTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      AppGaps.wGap5,
                      Text(
                        Helper.ddMMMyyyyFormattedDateTime(date),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyBoldTextStyle
                            .copyWith(color: AppColors.mainTextColor),
                      ),
                    ],
                  ),
                  if (status == 'complete')
                    Row(
                      children: [
                        Text(
                          AppLanguageTranslation
                              .endDateTransKey.toCurrentLanguage,
                          style: AppTextStyles.bodyTextStyle
                              .copyWith(color: AppColors.bodyTextColor),
                        ),
                        AppGaps.wGap5,
                        Text(
                          Helper.ddMMMyyyyFormattedDateTime(date),
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
