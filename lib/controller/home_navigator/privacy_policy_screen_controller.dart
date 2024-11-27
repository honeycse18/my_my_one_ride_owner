import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/support_text_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class PrivacyPolicyScreenController extends GetxController {
  // WebViewController webViewController = WebViewController();
  SupportTextItem supportTextItem = SupportTextItem.empty();

  Future<void> getSupportText() async {
    SupportTextResponse? response =
        await APIRepo.getSupportText(slug: 'privacy_policy');
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
    onSuccessRetrievingCategoriesList(response);
  }

  onSuccessRetrievingCategoriesList(SupportTextResponse response) {
    supportTextItem = response.data;
    update();
  }

  @override
  void onInit() {
    getSupportText();

    super.onInit();
  }
}
