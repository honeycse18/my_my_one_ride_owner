import 'package:get/get.dart';

class ImageZoomScreenController extends GetxController {
  String imageURL = '';

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is String) {
      imageURL = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }
}
