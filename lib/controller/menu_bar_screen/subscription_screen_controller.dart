import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/subscription_model_response.dart';
import 'package:one_ride_car_owner/models/api_responses/user_details_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class SubscriptionScreenController extends GetxController {
  RxBool toggleNotification = true.obs;
  UserDetailsData userDetails = UserDetailsData.empty();
  List<SubscriptionModelItem> subscriptionModelItem = [];

  Future<void> getSubscriptionList() async {
    SubscriptionModelResponse? response = await APIRepo.getSubscriptionModel();
    if (response == null) {
      Helper.showSnackBar(
          AppLanguageTranslation.noResponseSubTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingDetails(response);
  }

  onSuccessRetrievingDetails(SubscriptionModelResponse response) {
    subscriptionModelItem = response.data;
    /*  try {
      final foundSubscription = subscriptionModelItem.firstWhereOrNull(
          (element) => element.id == currentUserDetails.subscription.id);
      if (foundSubscription != null) {
        if (subscriptionModelItem.remove(foundSubscription)) {
          subscriptionModelItem.insert(0, foundSubscription);
        }
      }
    } catch (e) {
      log(e.toString());
    } */
    update();
  }

  @override
  void onInit() {
    userDetails = Helper.getUser();
    getSubscriptionList();
    super.onInit();
  }
}
