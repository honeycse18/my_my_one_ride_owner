import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/fakeModel/fake_data.dart';
import 'package:one_ride_car_owner/models/fakeModel/submit_review_screen_parameter.dart';
import 'package:one_ride_car_owner/models/screenParameters/select_screen_parameters.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionPaymentMethodScreenController extends GetxController {
  int selectedPaymentMethodIndex = 0;
  String? id;
  String? type;
  SelectPaymentOptionModel selectedPaymentOption =
      FakeData.subPaymentOptionList[0];

  Future<void> paymentAcceptSubscriptionRequest() async {
    final Map<String, String> requestBody = {
      'subscription': id ?? '',
      'type': type ?? '',
      'method': selectedPaymentOption.value,
    };
    RawAPIResponse? response =
        await APIRepo.paymentAcceptSubscriptionRequest(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    selectedPaymentOption.value == 'paypal'
        ? _onSucessPaymentStatus(response)
        : _onSucessWalletPaymentStatus(response);
    // _onSuccessAcceptCarRentRequest(response);
  }

  _onSucessPaymentStatus(RawAPIResponse response) async {
    await launchUrl(Uri.parse(response.data));
    update();
    Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    _initializeAfterDelay(response);
  }

  _onSucessWalletPaymentStatus(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
    Get.offAllNamed(AppPageNames.zoomDrawerScreen);
  }

  _initializeAfterDelay(RawAPIResponse response) async {
    await Future.delayed(Duration(seconds: 3));
    AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is SubsCriptionScreenParameters) {
      id = argument.id;
      type = argument.type;
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
