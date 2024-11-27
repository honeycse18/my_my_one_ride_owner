import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/language_screen_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/language_screen_widgets.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  /// Currently selected language
  // LanguageSetting currentLanguage = LanguageSetting.english;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageScreenController>(
        init: LanguageScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(
                    AppLanguageTranslation.languageTransKey.toCurrentLanguage,
                  )),
              /* <-------- Content --------> */
              body: CustomScaffoldBodyWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          AppLanguageTranslation
                              .selectLanguageTransKey.toCurrentLanguage,
                          style: AppTextStyles.bodyExtraLargeSemiboldTextStyle
                              .copyWith(color: AppColors.mainTextColor)),
                    ),
                    AppGaps.hGap10,
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          // Top extra spaces

                          const SliverToBoxAdapter(child: AppGaps.hGap16),
                          /* <---- Language choice list ----> */
                          SliverList.separated(
                            itemBuilder: (context, index) {
                              final language = controller.languages[index];
                              return LanguageListTileWidget(
                                  languageFlagLocalAssetFileName: language.flag,
                                  languageNameText: language.name,
                                  isLanguageSelected:
                                      controller.selectedLanguage.id ==
                                          language.id,
                                  onTap: () =>
                                      controller.onLanguageTap(language));
                            },
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                            itemCount: controller.languages.length,
                          ),
                          // Bottom extra spaces
                          const SliverToBoxAdapter(child: AppGaps.hGap30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
