import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:one_ride_car_owner/controller/fuel_complete_screen_bottomsheet_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class CompleteFuelManagementBottomSheet extends StatelessWidget {
  const CompleteFuelManagementBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteFuelScreenController>(
        init: CompleteFuelScreenController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              height: MediaQuery.of(context).size.height * 0.48,
              decoration: const BoxDecoration(
                  color: AppColors.mainBg,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(
                    children: [
                      RawButtonWidget(
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: AppColors.primaryBorderColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(14))),
                            child: const Center(
                                child: SvgPictureAssetWidget(
                                    AppAssetImages.arrowLeftSVGLogoLine))),
                        onTap: () {
                          Get.back();
                        },
                      )
                    ],
                  ),
                  AppGaps.hGap27,
                  CustomTextFormField(
                    textInputType: TextInputType.number,
                    controller: controller.endMeterNumber,
                    labelText: AppLanguageTranslation
                        .endMeterNoTransKey.toCurrentLanguage,
                    hintText: 'eg : 2025',
                  ),
                  AppGaps.hGap24,
                  CustomTextFormField(
                    labelText: AppLanguageTranslation
                        .fillDateTransKey.toCurrentLanguage,
                    hintText: AppLanguageTranslation
                        .startDateTransKey.toCurrentLanguage,
                    isReadOnly: true,
                    controller: TextEditingController(
                      text:
                          '${DateFormat('yyyy-MM-dd').format(controller.selectedDateEnd.value)}      ',
                    ),
                    prefixIcon: const SvgPictureAssetWidget(
                        AppAssetImages.calenderSVGLogoLine),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 100),
                      );
                      if (pickedDate != null) {
                        controller.updateSelectedStartDate(pickedDate);
                      }

                      controller.update();
                    },
                  ),
                  AppGaps.hGap28,
                  CustomStretchedTextButtonWidget(
                    buttonText: AppLanguageTranslation
                        .completeTransKey.toCurrentLanguage,
                    onTap: controller.updatefuel,
                  )
                ]),
              ),
            ));
  }
}
