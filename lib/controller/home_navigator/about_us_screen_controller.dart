import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/about_us_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class AboutusScreenController extends GetxController {
  // WebViewController webViewController = WebViewController();
  AboutUsData aboutUsTextItem = AboutUsData.empty();

  Future<void> getAboutusText() async {
    AboutUsResponse? response = await APIRepo.getAboutUsText();
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

  onSuccessRetrievingCategoriesList(AboutUsResponse response) {
    aboutUsTextItem = response.data;
    update();
  }

  @override
  void onInit() {
    getAboutusText();
    super.onInit();
  }
}
