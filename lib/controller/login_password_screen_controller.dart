import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:one_ride_car_owner/models/api_responses/login_response.dart';
import 'package:one_ride_car_owner/models/api_responses/otp_request_response.dart';
import 'package:one_ride_car_owner/models/api_responses/user_details_response.dart';
import 'package:one_ride_car_owner/models/screenParameters/sign_up_screen_parameter.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_local_stored_keys.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class LogInPasswordSCreenController extends GetxController {
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  RxBool toggleHidePassword = true.obs;
  TextEditingController passwordTextEditingController = TextEditingController();
  SignUpScreenParameter? screenParameter;
  Map<String, dynamic> credentials = {};
  bool isEmail = false;

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onForgotPasswordButtonTap() {
    forgotPassword();
  }

  Future<void> forgotPassword() async {
    String key = 'phone';
    String value = '';
    if (isEmail) {
      value = credentials['email'];
      key = 'email';
    } else {
      value = credentials['phone'];
    }
    Map<String, dynamic> requestBody = {
      key: value,
      'action': 'forgot_password'
    };
    OtpRequestResponse? response = await APIRepo.requestOTP(requestBody);
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
    onSuccessSendingOTP(response, value, requestBody);
  }

  onSuccessSendingOTP(OtpRequestResponse response, String data,
      Map<String, dynamic> requestBody) {
    Map<String, dynamic> forgetPasswordData = {
      // 'theData': data,
      'isEmail': screenParameter!.isEmail ? true : false,
      'isForRegistration': false,
      'action': 'forgot_password',
      'resendCode': requestBody
    };
    if (isEmail) {
      forgetPasswordData["email"] = data;
    } else {
      forgetPasswordData["phone"] = data;
    }
    Get.offNamed(AppPageNames.verificationScreen,
        arguments: forgetPasswordData);
  }

  void onLoginButtonTap() {
    /*  if (passwordFormKey.currentState?.validate() ?? false) {
      login();
    } */
    login();
  }

  Future<void> login() async {
    credentials['password'] = passwordTextEditingController.text;
    LoginResponse? response = await APIRepo.login(credentials);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noLoginTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessLogin(response);
  }

  onSuccessLogin(LoginResponse response) {
    fetchUserDetails(response.data.token);
    // Get.offNamed(AppPageNames.homeNavigatorScreen);
  }

  Future<void> fetchUserDetails(String token) async {
    await GetStorage().write(LocalStoredKeyName.loggedInCarOwnerToken, token);
    getLoggedInUserDetails(token);
    // UserDetailsResponse? response = await APIRepo.getUser(token);
  }

  Future<void> getLoggedInUserDetails(String token) async {
    UserDetailsResponse? response = await APIRepo.getUserDetails(token: token);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    BuildContext? context = Get.context;
    if (context != null) {
      Get.toNamed(AppPageNames.zoomDrawerScreen);
    }
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SignUpScreenParameter) {
      screenParameter = params;
      String key = 'phone';
      if (screenParameter!.isEmail) {
        key = 'email';
        isEmail = true;
      }
      credentials[key] = screenParameter!.theValue;
    }
    update();
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
