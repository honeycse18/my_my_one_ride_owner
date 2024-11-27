import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:intl/intl.dart';
import 'package:one_ride_car_owner/models/api_responses/user_details_response.dart';
import 'package:one_ride_car_owner/utils/app_singleton.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/constants/app_local_stored_keys.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/helpers/image_picker_helper.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';
import 'package:path_provider/path_provider.dart';

/// This file contains helper functions and properties
class Helper {
  static Size getScreenSize(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return screenSize;
  }

  static String getFirstSafeString(List<String> images) {
    return images.firstOrNull ?? '';
  }

  static String getUserBearerToken() {
    String loggedInUserToken = getUserToken();
    return 'Bearer $loggedInUserToken';
  }

  static UserDetailsData getUser() {
    dynamic loggedInUserJsonString =
        GetStorage().read(LocalStoredKeyName.loggedInCarOwner);
    if (loggedInUserJsonString is! String) {
      return UserDetailsData.empty();
    }
    dynamic loggedInUserJson = jsonDecode(loggedInUserJsonString);
/*     if (loggedInUserJson is! Map<String, dynamic>) {
      return UserDetails.empty();
    } */
    return UserDetailsData.getAPIResponseObjectSafeValue(loggedInUserJson);
  }

  static String getUserToken() {
    dynamic userToken =
        GetStorage().read(LocalStoredKeyName.loggedInCarOwnerToken);
    if (userToken is! String) {
      return '';
    }
    return userToken;
  }

  static String getRelativeDateTimeText(DateTime dateTime) {
    return DateTime.now().difference(dateTime).inDays == 1
        ? 'Yesterday'
        : timeago.format(dateTime);
  }

  static bool isUserLoggedIn() {
    return (getUserToken().isNotEmpty || (!getUser().isEmpty()));
  }

  static void logout() async {
    GetStorage().write(LocalStoredKeyName.loggedInCarOwnerToken, null);
    GetStorage().write(LocalStoredKeyName.loggedInCarOwner, null);
    await AppSingleton.instance.localBox.clear();

    Get.offAllNamed(AppPageNames.logInScreen);
  }

  static void pickImages(
      {String imageName = '',
      required void Function(List<Uint8List>, Map<String, dynamic>)
          onSuccessUploadSingleImage,
      Map<String, dynamic> additionalData = const {},
      String token = ''}) async {
    final List<image_picker.XFile>? pickedImages =
        await ImagePickerHelper.getPhoneImages();
    if (pickedImages == null || pickedImages.isEmpty) {
      return;
    }
    processPickedImages(pickedImages,
        onSuccessUploadSingleImage: onSuccessUploadSingleImage,
        imageName: imageName,
        additionalData: additionalData,
        token: token);
    AppDialogs.showProcessingDialog(message: 'Image is processing');
  }

  static void processPickedImages(List<image_picker.XFile> pickedImages,
      {required void Function(List<Uint8List>, Map<String, dynamic>)
          onSuccessUploadSingleImage,
      required String imageName,
      required Map<String, dynamic> additionalData,
      required String token}) async {
    List<Uint8List>? processedImages =
        await ImagePickerHelper.getProcessedImages(pickedImages);
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    /* if (processedImages == null) {
      AppDialogs.showErrorDialog(
          messageText: 'Error occurred while processing image');
      return;
    } */
    final String messageText = imageName.isEmpty
        ? 'Are you sure to set this image?'
        : 'Are you sure to set this image as $imageName?';
    Object? confirmResponse = await AppDialogs.showConfirmDialog(
      shouldCloseDialogOnceYesTapped: false,
      messageText: messageText,
      onYesTap: () async {
        return Get.back(result: true);
      },
    );
    if (confirmResponse is bool && confirmResponse) {
      onSuccessUploadSingleImage(processedImages, additionalData);
      // String imageFileName = '';
      // String id = '';
/*       Uri? logoUri = Uri.tryParse(vendorDetails.store.nidImage);
      if (logoUri != null) {
        if (logoUri.pathSegments.length >= 2) {
          // id = logoUri.pathSegments[logoUri.pathSegments.length - 2];
          // imageFileName = logoUri.pathSegments[logoUri.pathSegments.length - 1];
        }
      } */
      /* APIHelper.uploadSingleImage(processedImage, onSuccessUploadSingleImage,
          imageFileName: imageFileName,
          id: id,
          additionalData: additionalData,
          token: token); */
    }
  }

  static int getRandom6DigitGeneratedNumber() {
    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    double next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next.toInt();
  }

  static Future<File> getTempFileFromImageBytes(Uint8List imageBytes) async {
    final tempDir = await getTemporaryDirectory();
    File file =
        await File('${tempDir.path}/${getRandom6DigitGeneratedNumber()}.jpg')
            .create();
    return file.writeAsBytes(imageBytes);
  }

  static Future<void> setLoggedInUserToLocalStorage(
      UserDetailsData userDetails) async {
    var vendorDetailsMap = userDetails.toJson();
    String userDetailsJson = jsonEncode(vendorDetailsMap);
    await GetStorage()
        .write(LocalStoredKeyName.loggedInCarOwner, userDetailsJson);
  }

  static double getAvailableScreenHeightForBottomSheet(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    final double topUnavailableSpaceValue = MediaQuery.of(context).padding.top;
    final double topAvailableSpaceValue =
        screenSize.height - topUnavailableSpaceValue;
    return topAvailableSpaceValue;
  }

  /// Generate Material color
  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: _generateTintColor(color, 0.9),
      100: _generateTintColor(color, 0.8),
      200: _generateTintColor(color, 0.6),
      300: _generateTintColor(color, 0.4),
      400: _generateTintColor(color, 0.2),
      500: color,
      600: _generateShadeColor(color, 0.1),
      700: _generateShadeColor(color, 0.2),
      800: _generateShadeColor(color, 0.3),
      900: _generateShadeColor(color, 0.4),
    });
  }

  // Helper functions for above function
  static int _generateTintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color _generateTintColor(Color color, double factor) => Color.fromRGBO(
      _generateTintValue(color.red, factor),
      _generateTintValue(color.green, factor),
      _generateTintValue(color.blue, factor),
      1);

  static int _generateShadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static hideKeyBoard() {
    Future.delayed(
      const Duration(milliseconds: 0),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
  }

  static Color _generateShadeColor(Color color, double factor) =>
      Color.fromRGBO(
          _generateShadeValue(color.red, factor),
          _generateShadeValue(color.green, factor),
          _generateShadeValue(color.blue, factor),
          1);

  static void showSnackBar(String message) {
    BuildContext? context = Get.context;
    if (context != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  static Future<Position?> getGPSLocationData() async {
    try {
      // Test if location services are enabled.
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        AppDialogs.showErrorDialog(
            messageText: 'Location services are disabled. Please turn on GPS');
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          AppDialogs.showErrorDialog(
              messageText:
                  'Location permissions are denied. Please try again to permit location access');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        AppDialogs.showErrorDialog(
            messageText:
                'Location permissions are permanently denied, we cannot request permissions. You can permit location by going on app settings.');
        return null;
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      return null;
    }
  }

  static Color getColor(String hexCode) {
    final hexColor = hexCode.replaceFirst('#', '');
    return Color((int.tryParse(hexColor, radix: 16) ?? 0) + 0xFF000000);
  }

  static String ddMMMyyyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM, yyyy').format(dateTime);
  static String ddMMyyyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd-MM-yyyy').format(dateTime);
  static String ddmmyyyyhhmmFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM, yyyy | hh:mm a').format(dateTime);

  static String hhmmFormattedDateTime(DateTime dateTime) =>
      DateFormat('hh:mm a').format(dateTime);

  static String ddMMMyyyyhhmmaFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM,yyyy | hh:mm a').format(dateTime);
  static String hhmm24FormattedDateTime(TimeOfDay dateTime) =>
      DateFormat('hh:mm').format(
          DateTime(DateTime.now().year, 1, 0, dateTime.hour, dateTime.minute));
  static int dateTimeDifferenceInDays(DateTime date) {
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime.now())
        .inDays;
  }

  /// Returns if today, true
  static bool isToday(DateTime date) {
    return dateTimeDifferenceInDays(date) == 0;
  }

  /// Returns if tomorrow, true
  static bool isTomorrow(DateTime date) {
    return dateTimeDifferenceInDays(date) == 1;
  }

  /// Returns if yesterday, true
  static bool wasYesterday(DateTime date) {
    return dateTimeDifferenceInDays(date) == -1;
  }

  static String getCurrencyFormattedWithDecimalAmountText(double amount,
      [int decimalDigit = 2]) {
    return AppComponents.defaultDecimalNumberFormat.format(amount);
  }

  static void scrollToStart(ScrollController scrollController) {
    if (scrollController.hasClients && !scrollController.position.outOfRange) {
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  static String ddMMyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd/MM/yy').format(dateTime);

  static String hhMMaFormattedDate(DateTime dateTime) =>
      DateFormat('hh:mm a').format(dateTime);

  static String dayFullFormattedDateTime(DateTime dateTime) =>
      DateFormat('EEEE').format(dateTime);
  static String ddMMMyyyyhhmmFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM, yyyy | hh:mm a').format(dateTime);

  static String avatar2LetterUsername(String firstName, String lastName) {
    if (lastName.isEmpty) {
      if (firstName.isEmpty) {
        return '';
      }
      final firstCharacter = firstName.characters.first;
      final secondCharacter = firstName.characters.length >= 2
          ? firstName.characters.elementAt(1)
          : '';
      return '$firstCharacter$secondCharacter';
    }
    if (firstName.isEmpty) {
      return '';
    }
    final firstCharacter = firstName.characters.first;
    final secondCharacter = lastName.characters.first;
    return '$firstCharacter$secondCharacter';
  }

  static ({String dialCode, String strippedPhoneNumber})?
      separatePhoneAndDialCode(String fullPhoneNumber) {
    final foundCountryCode = codes.firstWhereOrNull(
        (code) => fullPhoneNumber.contains(code['dial_code'] ?? ''));
    if (foundCountryCode == null) {
      return null;
    }
    var dialCode = fullPhoneNumber.substring(
      0,
      foundCountryCode["dial_code"]!.length,
    );
    var newPhoneNumber = fullPhoneNumber.substring(
      foundCountryCode["dial_code"]!.length,
    );
    return (dialCode: dialCode, strippedPhoneNumber: newPhoneNumber);
  }

  static String? phoneFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isPhoneNumber(text)) {
        return 'Invalid phone number format';
      }
      return null;
    }
    return null;
  }

  static String? emailFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isEmail(text)) {
        return 'Invalid email format';
      }
      return null;
    }
    return null;
  }

  static String? passwordFormValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Password is required';
    } else if (text.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'(?=.*?[A-Z])').hasMatch(text)) {
      return 'Password must include at least 1 uppercase letter';
    } else if (!RegExp(r'(?=.*?[a-z])').hasMatch(text)) {
      return 'Password must include at least 1 lowercase letter';
    } else if (!RegExp(r'(?=.*?[0-9])').hasMatch(text)) {
      return 'Password must include at least 1 number';
    } else if (!RegExp(r'(?=.*?[!@#$%^&*])').hasMatch(text)) {
      return 'Password must include at least 1 special character (!@#\$%^&*)';
    }
    return null;
  }

  /// used to check User name Input Field Should no empty
  static String? textFormValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) return 'Can not be empty';
      if (text.length < 3) return 'Minimum length 3';
    }
    return null;
  }
}
