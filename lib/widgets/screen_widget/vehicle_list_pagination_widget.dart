import 'package:flutter/widgets.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class VehicleListItemWidget extends StatelessWidget {
  final String carName;
  final String carCategory;
  final String carNumber;
  final String carImage;
  final void Function()? onTap;

  const VehicleListItemWidget(
      {super.key,
      required this.carName,
      required this.carCategory,
      required this.carNumber,
      required this.carImage,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        onTap: onTap,
        hasShadow: true,
        paddingValue: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(
              height: 70,
              width: 70,
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
                AppGaps.hGap6,
                Text(
                  carCategory,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmallTextStyle
                      .copyWith(color: AppColors.bodyTextColor),
                ),
                AppGaps.hGap6,
                Text(
                  carNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyTextStyle
                      .copyWith(color: AppColors.bodyTextColor),
                ),
              ],
            ))
          ],
        ));
  }
}
