import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
// import 'package:country_code_picker/src/country_code.dart' as codes;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/otp_request_response.dart';
import 'package:one_ride_car_owner/models/screenParameters/sign_up_screen_parameter.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class RegistrationScreenController extends GetxController {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final RxBool isDropdownOpen = false.obs;
  final RxString selectedGender = 'Select Gender'.obs;
  SignUpScreenParameter? screenParameter;
  bool isEmail = true;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('BD');

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
    isDropdownOpen.value = false;
  }

  String? passwordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != confirmPasswordTextEditingController.text) {
        return AppLanguageTranslation
            .mustMatchPasswordTransKey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  String? confirmPasswordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != passwordTextEditingController.text) {
        return AppLanguageTranslation
            .notMatchPasswordTransKey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  /// Toggle value of hide password
  RxBool toggleHidePassword = true.obs;

  /// Toggle value of hide confirm password
  RxBool toggleHideConfirmPassword = true.obs;
  RxBool toggleAgreeTermsConditions = false.obs;

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onConfirmPasswordSuffixEyeButtonTap() {
    toggleHideConfirmPassword.value = !toggleHideConfirmPassword.value;
  }

  void onToggleAgreeTermsConditions(bool? value) {
    toggleAgreeTermsConditions.value = value ?? false;
    update();
  }

  bool checkEmpty(TextEditingController controller) {
    return controller.text.isEmpty;
  }

  void onContinueButtonTap() {
    /*  if (checkEmpty(passwordTextEditingController) ||
        passwordTextEditingController.text !=
            confirmPasswordTextEditingController.text) {
      AppDialogs.showErrorDialog(messageText: 'Passwords don\'t match!');
      return;
    } */
    /*  if (checkEmpty(nameTextEditingController) ||
        checkEmpty(emailTextEditingController) ||
        checkEmpty(phoneTextEditingController)) {
      AppDialogs.showErrorDialog(
          messageText: 'Please fill out all required fields first!');
      return;
    } */
    if (signUpFormKey.currentState?.validate() ?? false) {
      if (!toggleAgreeTermsConditions.value) {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .mutAgreeRequestTransKey.toCurrentLanguage);
        return;
      }
      String key = 'phone';
      String value = getPhoneFormatted();
      if (isEmail) {
        key = 'email';
        value = emailTextEditingController.text;
      }
      Map<String, dynamic> requestBodyForOTP = {
        key: value,
        'action': 'registration',
      };
      requestForOTP(requestBodyForOTP);
    }
  }

  Future<void> requestForOTP(Map<String, dynamic> data) async {
    OtpRequestResponse? response = await APIRepo.requestOTP(data);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseOtpTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessSendingOTP(response);
  }

  String getPhoneFormatted() {
    return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
  }

  onSuccessSendingOTP(OtpRequestResponse response) {
    Map<String, dynamic> registrationData = {
      'name': nameTextEditingController.text,
      'phone': getPhoneFormatted(),
      'email': emailTextEditingController.text,
      'password': passwordTextEditingController.text,
      'confirm_password': confirmPasswordTextEditingController.text,
      'role': 'owner',
      'isEmail': isEmail,
      'isForRegistration': true
    };
    Get.toNamed(AppPageNames.verificationScreen, arguments: registrationData);
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SignUpScreenParameter) {
      screenParameter = params;
      isEmail = screenParameter!.isEmail;
      if (screenParameter!.isEmail) {
        emailTextEditingController.text = screenParameter!.theValue;
      } else {
        phoneTextEditingController.text = screenParameter!.theValue;
        currentCountryCode =
            screenParameter!.countryCode ?? CountryCode.fromCountryCode('BD');
      }
    }
    update();
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
