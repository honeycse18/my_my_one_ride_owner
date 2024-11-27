import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

/// Language list tile widget from language selection screen
class LanguageListTileWidget extends StatelessWidget {
  final void Function()? onTap;
  final String languageNameText;
  final String languageFlagLocalAssetFileName;
  final bool isLanguageSelected;
  const LanguageListTileWidget({
    Key? key,
    this.onTap,
    required this.languageNameText,
    required this.languageFlagLocalAssetFileName,
    required this.isLanguageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: CustomListTileWidget(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (languageFlagLocalAssetFileName.isNotEmpty)
                Container(
                  height: 24,
                  width: 24,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  )),
                  child: Image.asset(
                    'flags/${languageFlagLocalAssetFileName.toLowerCase()}.png',
                    package: 'country_code_picker',
                    fit: BoxFit.contain,
                  ),
                ),
              if (languageFlagLocalAssetFileName.isNotEmpty) AppGaps.wGap16,
              Expanded(
                child: Text(
                  languageNameText,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              isLanguageSelected
                  ? const SvgPictureAssetWidget(
                      AppAssetImages.tickRoundedSVGLogoSolid,
                      color: AppColors.mainTextColor)
                  : AppGaps.emptyGap,
            ],
          )),
    );
  }
}
