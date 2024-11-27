import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/settings_screen_widgets.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class FleetManagementScreen extends StatelessWidget {
  const FleetManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleWidget: Text(AppLanguageTranslation
              .fleetManagementTransKey.toCurrentLanguage)),
      body: ScaffoldBodyWidget(
          child: SingleChildScrollView(
        child: Column(children: [
          AppGaps.hGap10,
          SettingsListTileWidget(
              titleText: AppLanguageTranslation
                  .fuelManagementTransKey.toCurrentLanguage,
              onTap: () {
                Get.toNamed(AppPageNames.fuelManagementListScreen);
              }),
          AppGaps.hGap24,
          SettingsListTileWidget(
              titleText:
                  AppLanguageTranslation.maintenanceTransKey.toCurrentLanguage,
              onTap: () {
                Get.toNamed(AppPageNames.maintananceScreen);
              }),
        ]),
      )),
    );
  }
}
