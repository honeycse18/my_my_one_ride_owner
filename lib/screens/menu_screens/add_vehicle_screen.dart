import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/add_vehicle_screen_controller.dart';
import 'package:one_ride_car_owner/models/enums.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/add_vehicle_tab_widget.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddVehicleScreenController>(
        global: false,
        init: AddVehicleScreenController(),
        builder: (controller) => Scaffold(
            backgroundColor: AppColors.mainBg,
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: true,
                titleWidget: Text(AppLanguageTranslation
                    .vehicleDetailsTransKey.toCurrentLanguage)),
            body: ScaffoldBodyWidget(
                child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                          child: Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppGaps.hGap16,
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                      child: GestureDetector(
                                    child: AddVehicleTabWidget(
                                      isLine: true,
                                      tabIndex: 1,
                                      tabName:
                                          '${AppLanguageTranslation.stepTransKey.toCurrentLanguage} 1',
                                      myTabState: AddVehicleTabState.step1,
                                      currentTabState:
                                          controller.addVehicleState.value,
                                    ),
                                    onTap: () {
                                      controller.addVehicleState.value =
                                          AddVehicleTabState.step1;
                                    },
                                  )),
                                  Expanded(
                                      child: GestureDetector(
                                    child: AddVehicleTabWidget(
                                      isLine: true,
                                      tabIndex: 2,
                                      tabName:
                                          '${AppLanguageTranslation.stepTransKey.toCurrentLanguage} 2',
                                      myTabState: AddVehicleTabState.step2,
                                      currentTabState:
                                          controller.addVehicleState.value,
                                    ),
                                    onTap: () {
                                      controller.addVehicleState.value =
                                          AddVehicleTabState.step2;
                                    },
                                  )),
                                  Expanded(
                                      child: GestureDetector(
                                    child: AddVehicleTabWidget(
                                      tabIndex: 3,
                                      tabName:
                                          '${AppLanguageTranslation.stepTransKey.toCurrentLanguage} 3',
                                      myTabState: AddVehicleTabState.step3,
                                      currentTabState:
                                          controller.addVehicleState.value,
                                    ),
                                    onTap: () {
                                      controller.addVehicleState.value =
                                          AddVehicleTabState.step3;
                                    },
                                  )),
                                ]),
                            AppGaps.hGap16,
                            ...controller.currentOrderDetailsTabContentWidgets(
                                controller.addVehicleState.value),
                          ],
                        ),
                      )),
                    ],
                  ),
                )
              ],
            )),
            bottomNavigationBar: CustomScaffoldBodyWidget(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(10),
                      child:
                          controller.currentOrderDetailsTabBottomButtonWidget(
                              controller.addVehicleState.value),
                    ),
                  ),
                ],
              ),
            )));
  }
}
