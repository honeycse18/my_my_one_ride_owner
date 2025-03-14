import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/fakeModel/submit_review_screen_parameter.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class SubmitReviewBottomSheetScreenController extends GetxController {
  final GlobalKey<FormState> submitReviewFormKey = GlobalKey<FormState>();
  SubmitReviewScreenParameter? submitReview;
  TextEditingController commentTextEditingController = TextEditingController();

  RxDouble rating = 0.0.obs;

  void setRating(double value) {
    rating.value = value;
    update();
  }

  //------------post method---------------
  Future<void> submitRentReview() async {
    Map<String, dynamic> requestBody = {
      'object': submitReview!.id,
      'type': submitReview!.type,
      'rating': rating.value,
      'comment': commentTextEditingController.text
    };
    RawAPIResponse? response = await APIRepo.submitReviews(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSucessSendMessage(response);
  }

  void _onSucessSendMessage(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SubmitReviewScreenParameter) {
      submitReview = params;
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
