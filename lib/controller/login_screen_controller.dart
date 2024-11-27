import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/find_account_response.dart';
import 'package:one_ride_car_owner/models/screenParameters/sign_up_screen_parameter.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class LogInScreenController extends GetxController {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  bool phoneMethod = true;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('BD');

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  String getPhoneFormatted() {
    return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
  }

  void onContinueButtonTap() {
    findAccount();
  }

  Future<void> findAccount() async {
    String key = 'email';
    String value = emailTextEditingController.text;
    if (phoneMethod) {
      key = 'phone';
      value = getPhoneFormatted();
    }
    final Map<String, dynamic> requestBody = {
      key: value,
    };
    FindAccountResponse? response = await APIRepo.findAccount(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessFindingAccount(response);
  }

  onSuccessFindingAccount(FindAccountResponse response) {
    bool hasAccount = response.data.account;
    log(response.data.role);
    if (hasAccount) {
      if (response.data.role == AppConstants.userRoleUser) {
        Get.toNamed(AppPageNames.logInPasswordScreen,
            arguments: SignUpScreenParameter(
                isEmail: !phoneMethod,
                theValue: phoneMethod
                    ? getPhoneFormatted()
                    : emailTextEditingController.text));
      } else {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .alreadyHaveAccountTransKey.toCurrentLanguage);
        return;
      }
    } else {
      Get.toNamed(AppPageNames.registrationScreen,
          arguments: SignUpScreenParameter(
              isEmail: !phoneMethod,
              countryCode: currentCountryCode,
              theValue: phoneMethod
                  ? phoneTextEditingController.text
                  : emailTextEditingController.text));
    }
  }

  void onMethodButtonTap() {
    phoneMethod = !phoneMethod;
    update();
  }
}
