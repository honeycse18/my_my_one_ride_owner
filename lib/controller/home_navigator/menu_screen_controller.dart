import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:one_ride_car_owner/models/api_responses/user_details_response.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';

class MenuScreenController extends GetxController {
  UserDetailsData userDetails = UserDetailsData.empty();

  void onLogOutButtonTap() {
    Helper.logout();
  }

  getUserDetails() {
    userDetails = Helper.getUser();
    update();
  }

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }
}
