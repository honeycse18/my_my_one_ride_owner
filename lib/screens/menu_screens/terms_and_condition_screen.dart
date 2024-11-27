import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/home_navigator/terms_condition_screen_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TermsConditionScreenController>(
        init: TermsConditionScreenController(),
        builder: (controller) => Scaffold(
            backgroundColor: AppColors.mainBg,

            /* <-------- Appbar --------> */
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleWidget: Text(
                    AppLanguageTranslation.termTransKey.toCurrentLanguage)),

            /* <-------- Content --------> */

            body: ScaffoldBodyWidget(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap10,
                    HtmlWidget(controller.supportTextItem.content),
                    AppGaps.hGap50,
                  ],
                ),
              ),
            )

            /* <-------- Bottom bar of sign up text --------> */
            ));
  }
}
