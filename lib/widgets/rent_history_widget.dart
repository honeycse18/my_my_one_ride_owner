import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class RentHistoryWidget extends StatelessWidget {
  final String userNmae;
  final String userImage;
  final String driverNmae;
  final String driverImage;
  final DateTime dateTime;
  final int quantity;
  final String type;
  final void Function()? onTap;
  final void Function()? onSendTap;

  const RentHistoryWidget({
    super.key,
    required this.userNmae,
    required this.userImage,
    required this.driverNmae,
    required this.driverImage,
    required this.dateTime,
    required this.quantity,
    required this.type,
    this.onTap,
    this.onSendTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
      onTap: onTap,
      hasShadow: true,
      paddingValue: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CachedNetworkImageWidget(
                  imageURL: userImage,
                  imageBuilder: (context, imageProvider) => Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: AppComponents.imageBorderRadius,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                ),
              ),
              AppGaps.wGap10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userNmae,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLargeSemiboldTextStyle,
                    ),
                    AppGaps.hGap8,
                    Row(
                      children: [
                        const SingleStarWidget(review: 2),
                        AppGaps.wGap5,
                        Text(
                          '(531 ${AppLanguageTranslation.reviewTransKey.toCurrentLanguage})',
                          style: AppTextStyles.captionTextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
              AppGaps.wGap10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Helper.hhmmFormattedDateTime(dateTime),
                    style: AppTextStyles.bodyLargeSemiboldTextStyle
                        .copyWith(color: AppColors.mainTextColor),
                  ),
                  AppGaps.hGap10,
                  Text(
                    Helper.ddMMMyyyyFormattedDateTime(dateTime),
                    style: AppTextStyles.bodySmallTextStyle
                        .copyWith(color: AppColors.bodyTextColor),
                  ),
                ],
              )
            ],
          ),
          AppGaps.hGap8,
          Row(
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryBorderColor),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: const Center(
                    child: RawButtonWidget(
                        child: SvgPictureAssetWidget(
                            AppAssetImages.callSvgFillIcon))),
              ),
              AppGaps.wGap8,
              Expanded(
                  child: CustomMessageTextFormField(
                onTap: onSendTap,
                isReadOnly: true,
                suffixIcon:
                    const SvgPictureAssetWidget(AppAssetImages.sendSVGLogoLine),
                boxHeight: 55,
                hintText: AppLanguageTranslation
                    .messageYourDriverTransKey.toCurrentLanguage,
              ))
            ],
          )
        ],
      ),
    );
  }
}
