import 'dart:developer';
import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/bottom_sheet_controller/submit_otp_start_trip_bottomsheet_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class SubmitOtpStartRideBottomSheet extends StatelessWidget {
  const SubmitOtpStartRideBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubmitOtpStartRideBottomSheetController>(
        init: SubmitOtpStartRideBottomSheetController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 12,
              ),
              height: MediaQuery.of(context).size.height * 0.38,
              decoration: const BoxDecoration(
                  color: AppColors.mainBg,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                Container(
                  width: 60,
                  height: 2,
                  color: Colors.grey,
                ),
                AppGaps.hGap27,
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: const Center(
                          child: SvgPictureAssetWidget(
                        AppAssetImages.arrowLeftSVGLogoLine,
                        color: AppColors.darkColor,
                      )),
                    ),
                    const Spacer(),
                    Text(
                      AppLanguageTranslation
                          .submitOtpTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleBoldTextStyle,
                    ),
                    AppGaps.wGap30,
                    const Spacer(),
                  ],
                ),
                AppGaps.hGap27,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLanguageTranslation.otpTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyLargeMediumTextStyle,
                    ),
                    AppGaps.wGap4,
                    Text(
                      AppLanguageTranslation
                          .userProvideTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodySmallTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                  ],
                ),
                AppGaps.hGap8,
                CustomTextFormField(
                  textInputType: TextInputType.number,
                  controller: controller.otpTextEditingController,
                  hintText: 'eg,0515',
                ),
                AppGaps.hGap32,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ActionSlider.standard(
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2))
                      ],
                      icon: Transform.scale(
                          scaleX: -1,
                          child: const SvgPictureAssetWidget(
                              AppAssetImages.arrowLeftSVGLogoLine,
                              color: Colors.white)),
                      successIcon: const SvgPictureAssetWidget(
                        AppAssetImages.tickIconSVG,
                        color: Colors.white,
                        height: 34,
                        width: 34,
                      ),
                      foregroundBorderRadius:
                          const BorderRadius.all(Radius.circular(18)),
                      backgroundBorderRadius:
                          const BorderRadius.all(Radius.circular(18)),
                      sliderBehavior: SliderBehavior.stretch,
                      width: MediaQuery.of(context).size.width * 0.85,
                      backgroundColor: AppColors.primaryColor,
                      toggleColor: const Color(0xFFF9B56C),
                      action: (slideController) async {
                        slideController.loading(); //starts loading animation
                        await Future.delayed(const Duration(seconds: 2));
                        await controller.startRentStatus();
                        if (controller.isSuccess) {
                          await Future.delayed(const Duration(seconds: 1));
                          slideController.success();
                        } else {
                          slideController.failure();
                          controller.otpTextEditingController.clear();
                          slideController.reset();
                        } //starts success animation

                        // controller.reset();
                        log('successfully tapped');
                        await Future.delayed(const Duration(seconds: 1));

                        Get.offNamed(AppPageNames.zoomDrawerScreen,
                            arguments: 0);

                        //resets the slider
                      },
                      child: Text(
                        AppLanguageTranslation
                            .swipeToStartTransKey.toCurrentLanguage,
                        style: AppTextStyles.semiSmallXBoldTextStyle
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ]),
            ));
  }
}
