import 'package:get/get.dart';

class UpgradeSubscriptionScreenController extends GetxController {
  var selectedValue = 'monthly'.obs;

  void updateSelectedValue(String newValue) {
    selectedValue.value = newValue;
  }

  void onWithdrawRadioChange(String newValue) {
    selectedValue.value = newValue;
  }
}
