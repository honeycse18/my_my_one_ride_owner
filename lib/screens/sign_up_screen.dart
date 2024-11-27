import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/registration_screen_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<RegistrationScreenController>(
      init: RegistrationScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleWidget: Text(AppLanguageTranslation.registrationTransKey.toCurrentLanguage),
        ),
        body: SafeArea(
          child: CustomScaffoldBodyWidget(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: controller.signUpFormKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppGaps.hGap15,
                    AppGaps.hGap20,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextFormField(
                                validator: Helper.textFormValidator,
                                controller:
                                    controller.nameTextEditingController,
                                labelText: AppLanguageTranslation.yourNameTransKey.toCurrentLanguage,
                                hintText: AppLanguageTranslation.yourNameTransKey.toCurrentLanguage,
                                prefixIcon: SvgPicture.asset(
                                    AppAssetImages.profileSVGLogoLine)),
                            AppGaps.hGap16,
                            CustomTextFormField(
                                validator: Helper.emailFormValidator,
                                controller:
                                    controller.emailTextEditingController,
                                isReadOnly: controller.screenParameter!.isEmail,
                                labelText: AppLanguageTranslation.emailAddressTransKey.toCurrentLanguage,
                                hintText: 'example@gmail.com',
                                prefixIcon:
                                    SvgPicture.asset(AppAssetImages.email)),
                            AppGaps.hGap16,
                            PhoneNumberTextFormFieldWidget(
                              validator: Helper.phoneFormValidator,
                              initialCountryCode: controller.currentCountryCode,
                              controller: controller.phoneTextEditingController,
                              isReadOnly: !controller.screenParameter!.isEmail,
                              labelText: AppLanguageTranslation.phoneNumberTransKey.toCurrentLanguage,
                              hintText: '197464646',
                              onCountryCodeChanged: controller.onCountryChange,
                            ),
                            AppGaps.hGap16,
                            AppGaps.hGap16,
                            Obx(() => CustomTextFormField(
                                  validator: controller.passwordFormValidator,
                                  controller:
                                      controller.passwordTextEditingController,
                                  isPasswordTextField:
                                      controller.toggleHidePassword.value,
                                  labelText: AppLanguageTranslation.passwordTransKey.toCurrentLanguage,
                                  hintText: '********',
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.unlockSVGLogoLine),
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: controller
                                          .onPasswordSuffixEyeButtonTap,
                                      icon: SvgPictureAssetWidget(
                                          controller.toggleHidePassword.value
                                              ? AppAssetImages.hideSVGLogoLine
                                              : AppAssetImages.showSVGLogoLine,
                                          color: controller
                                                  .toggleHidePassword.value
                                              ? AppColors.bodyTextColor
                                              : AppColors.mainTextColor)),
                                )),
                            AppGaps.hGap16,
                            Obx(() => CustomTextFormField(
                                  validator:
                                      controller.confirmPasswordFormValidator,
                                  controller: controller
                                      .confirmPasswordTextEditingController,
                                  isPasswordTextField: controller
                                      .toggleHideConfirmPassword.value,
                                  labelText: AppLanguageTranslation.confirmPasswordTransKey
                                      .toCurrentLanguage,
                                  hintText: '********',
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.unlockSVGLogoLine),
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: controller
                                          .onConfirmPasswordSuffixEyeButtonTap,
                                      icon: SvgPictureAssetWidget(
                                          controller.toggleHideConfirmPassword
                                                  .value
                                              ? AppAssetImages.hideSVGLogoLine
                                              : AppAssetImages.showSVGLogoLine,
                                          color: controller
                                                  .toggleHideConfirmPassword
                                                  .value
                                              ? AppColors.bodyTextColor
                                              : AppColors.mainTextColor)),
                                )),
                            AppGaps.hGap5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: screenSize.width < 458
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: AppColors.mainTextColor)),
                                      child: Obx(() => Checkbox(
                                          checkColor: AppColors.mainTextColor,
                                          hoverColor: AppColors.mainTextColor,
                                          value: controller
                                              .toggleAgreeTermsConditions.value,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                          shape: const RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color:
                                                      AppColors.mainTextColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          onChanged: controller
                                              .onToggleAgreeTermsConditions)),
                                    ),
                                  ),
                                ),
                                AppGaps.wGap16,
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        controller.onToggleAgreeTermsConditions(
                                            !controller
                                                .toggleAgreeTermsConditions
                                                .value),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                         Text(
                                          AppLanguageTranslation.bySigningTransKey
                                              .toCurrentLanguage,
                                          style:
                                              AppTextStyles.bodyLargeTextStyle,
                                        ),
                                        AppGaps.wGap5,
                                        CustomTightTextButtonWidget(
                                            onTap: () {
                                              Get.toNamed(AppPageNames
                                                  .termsConditionScreen);
                                            },
                                            child: Text(
                                              AppLanguageTranslation.termsServiceTransKey
                                                  .toCurrentLanguage,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: AppColors
                                                          .mainTextColor),
                                            )),
                                        AppGaps.wGap5,
                                         Text(AppLanguageTranslation.andTransKey.toCurrentLanguage),
                                        AppGaps.wGap5,
                                        CustomTightTextButtonWidget(
                                            onTap: () {
                                              Get.toNamed(AppPageNames
                                                  .privacyPolicyScreen);
                                            },
                                            child: Text(
                                              AppLanguageTranslation.privacyPolicyTransKey
                                                  .toCurrentLanguage,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: AppColors
                                                          .mainTextColor),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap69,
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 37, right: 24, left: 24),
          child: Obx(() => controller.toggleAgreeTermsConditions.value
              ? CustomStretchedTextButtonWidget(
                  buttonText: AppLanguageTranslation.continueTransKey.toCurrentLanguage,
                  onTap: controller
                      .onContinueButtonTap /* () {
                        Get.toNamed(AppPageNames.verificationScreen);
                      } */
                  ,
                )
              : CustomStretchedTextButtonWidget(
                  buttonText: AppLanguageTranslation.continueTransKey.toCurrentLanguage,
                )),
        ),
      ),
    );
  }
}
