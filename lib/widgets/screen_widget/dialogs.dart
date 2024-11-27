import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:vibration/vibration.dart';

class AppDialogs {
  static Future<Object?> showSuccessDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.successTransKey.toCurrentLanguage;
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: AppColors.primaryColor,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.successIconImage),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: AppColors.successColor),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(
        messageText,
        style: AppTextStyles.bodyLargeSemiboldTextStyle
            .copyWith(color: AppColors.mainTextColor),
        textAlign: TextAlign.center,
      ),
      actionWidgets: [
        /* CustomStretchedTextButtonWidget(
          buttonText: 'Okay',
          // backgroundColor: AppColors.successColor,
          onTap: () {
            Get.back();
          },
        ) */
        CustomDialogButtonWidget(
            // backgroundColor: AppColors.alertColor,
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.okTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

  static Future<Object?> showExpireDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.sorryTransKey.toCurrentLanguage;
    // Vibrate the phone
    final hasVibrator = await Vibration.hasVibrator();

    // Check if hasVibrator is not null and is true
    if (hasVibrator == true) {
      Vibration.vibrate(duration: 500); // Vibrate for 500 milliseconds
    }
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: AppColors.primaryColor,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.showErrorAlert),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomDialogButtonWidget(
            // backgroundColor: AppColors.alertColor,
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.loginTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

  static Future<Object?> showErrorDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.sorryTransKey.toCurrentLanguage;
    // Vibrate the phone
    final hasVibrator = await Vibration.hasVibrator();

    // Check if hasVibrator is not null and is true
    if (hasVibrator == true) {
      Vibration.vibrate(duration: 500); // Vibrate for 500 milliseconds
    }
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: AppColors.primaryColor,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.showErrorAlert),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle
              .copyWith(color: AppColors.mainTextColor)),
      actionWidgets: [
        CustomDialogButtonWidget(
            // backgroundColor: AppColors.alertColor,
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.okTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

  static Future<Object?> showConfirmDialog({
    String? titleText,
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: AppColors.primaryColor,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.confirmIconImage),
          AppGaps.hGap16,
          Text(
              titleText ??
                  AppLanguageTranslation.confirmTransKey.toCurrentLanguage,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: const Color(0xFF3B82F6)),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          style: AppTextStyles.bodyLargeSemiboldTextStyle
              .copyWith(color: AppColors.mainTextColor)),
      actionWidgets: [
        Row(
          children: [
            Expanded(
                child: RawButtonWidget(
              onTap: onNoTap ??
                  () {
                    Get.back();
                  },
              child: Container(
                height: 62,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border:
                        Border.all(color: AppColors.mainTextColor, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                child: Center(
                  child: Text(
                    noButtonText ??
                        AppLanguageTranslation
                            .noAllowedTransKey.toCurrentLanguage,
                    style: AppTextStyles.bodyExtraLargeSemiboldTextStyle
                        .copyWith(color: AppColors.mainTextColor),
                  ),
                ),
              ),
            )),
            AppGaps.wGap12,
            Expanded(
              child: Expanded(
                  child: RawButtonWidget(
                onTap: () async {
                  await onYesTap();
                  if (shouldCloseDialogOnceYesTapped) Get.back();
                },
                child: Container(
                  height: 62,
                  decoration: BoxDecoration(
                      color: AppColors.mainTextColor.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: Center(
                    child: Text(
                      yesButtonText ??
                          AppLanguageTranslation
                              .yesAllowedTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyExtraLargeSemiboldTextStyle
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                ),
              )), /* CustomStretchedTextButtonWidget(
                buttonText: yesButtonText,
                onTap: () async {
                  await onYesTap();
                  if (shouldCloseDialogOnceYesTapped) Get.back();
                },
              ), */
            ),
          ],
        )
      ],
    ));
  }

  static Future<Object?> showActionableDialog(
      {String? titleText ,
      required String messageText,
      Color titleTextColor = AppColors.alertColor,
      String? buttonText ,
      void Function()? onTap}) async {
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: AppColors.alertBackgroundColor,
      titleWidget: Text(titleText??AppLanguageTranslation.errorTransKey.toCurrentLanguage,
          style: AppTextStyles.titleSmallSemiboldTextStyle
              .copyWith(color: titleTextColor),
          textAlign: TextAlign.center),
      contentWidget:
          Text(messageText, style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomStretchedTextButtonWidget(
          buttonText: buttonText??AppLanguageTranslation.okTransKey.toCurrentLanguage,
          // backgroundColor: AppColors.alertColor,
          onTap: onTap,
        )
      ],
    ));
  }

  static Future<Object?> showImageProcessingDialog() async {
    return await Get.dialog(
         AlertDialogWidget(
          titleWidget: Text(AppLanguageTranslation.imageProcessingTransKey.toCurrentLanguage,
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(AppLanguageTranslation.pleaseWaitTransKey.toCurrentLanguage),
            ],
          ),
        ),
        barrierDismissible: false);
  }

  static Future<Object?> showProcessingDialog(
      {String? message }) async {
    return await Get.dialog(
        AlertDialogWidget(
          titleWidget: Text(message??AppLanguageTranslation.processingTransKey.toCurrentLanguage,
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(AppLanguageTranslation.pleaseWaitTransKey.toCurrentLanguage),
            ],
          ),
        ),
        barrierDismissible: false);
  }
}
