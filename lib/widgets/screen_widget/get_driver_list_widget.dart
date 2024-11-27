import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class GetSearchDriverListItemWidget extends StatelessWidget {
  final String driverName;
  final String driverUid;
  final String driverImage;
  final void Function()? onAddTap;
  final void Function()? onTap;

  const GetSearchDriverListItemWidget({
    super.key,
    required this.driverName,
    required this.driverUid,
    required this.driverImage,
    this.onAddTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        onTap: onTap,
        hasShadow: true,
        paddingValue: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 85,
              width: 80,
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
                  driverUid,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyLargeSemiboldTextStyle,
                ),
                AppGaps.hGap6,
                Text(
                  driverName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmallTextStyle.copyWith(
                      color: AppColors.mainTextColor.withOpacity(0.6)),
                ),
                AppGaps.hGap6,
                AppGaps.hGap6,
              ],
            )),
            AppGaps.wGap12,
            TightSmallTextButtonWidget(
                text: AppLanguageTranslation.addDriverTransKey.toCurrentLanguage,
                onTap: onAddTap,
                textStyle: AppTextStyles.bodySmallSemiboldTextStyle.copyWith(
                    color: AppColors.mainTextColor,
                    decoration: TextDecoration.underline)),
          ],
        ));
  }
}
