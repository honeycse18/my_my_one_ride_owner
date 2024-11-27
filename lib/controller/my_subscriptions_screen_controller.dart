import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/my_subscription_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/user_details_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class MySubscriptionsScreenController extends GetxController {
  UserDetailsData currentUserDetails = UserDetailsData.empty();

  List<MySubscriptionItem> mySubscriptionsModelItem = [];

  Future<void> getMySubscriptionList() async {
    MySubscriptionListResponse? response =
        await APIRepo.getMySubscriptionModel();
    if (response == null) {
      Helper.showSnackBar(
          AppLanguageTranslation.noResponseSubTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    onSuccessMySubscriptionList(response);
  }

  onSuccessMySubscriptionList(MySubscriptionListResponse response) {
    mySubscriptionsModelItem = response.data;
    try {
      final foundSubscription = mySubscriptionsModelItem.firstWhereOrNull(
          (element) =>
              element.id ==
              currentUserDetails.subscription.subscriptionName.id);
      if (foundSubscription != null) {
        if (mySubscriptionsModelItem.remove(foundSubscription)) {
          mySubscriptionsModelItem.insert(0, foundSubscription);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    currentUserDetails = Helper.getUser();
    getMySubscriptionList();
    super.onInit();
  }
}
