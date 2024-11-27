import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_car_owner/utils/constants/app_secrets.dart';

/// This is a Barrel file containing custom configurations of this app. Import
/// this one file to import all the files from below.
export 'app_colors.dart';
export 'app_components.dart';
export 'app_gaps.dart';
export 'app_images.dart';

class AppConstants {
  static const String appLiveBaseURL = 'https://backend.1rides.com';
  // static const String appLiveBaseURL = 'https://1ridebackend.appstick.com.bd';

  static const String appLocalhostBaseURL = 'http://192.168.0.160:4200';
  static const bool isTestOnLocalhost = false;
  static const String appBaseURL =
      isTestOnLocalhost ? appLocalhostBaseURL : appLiveBaseURL;

  static const String googleMapBaseURL = 'https://maps.googleapis.com';

  static const String apiContentTypeFormURLEncoded =
      'application/x-www-form-urlencoded';
  static const String apiContentTypeFormData = 'multipart/form-data';
  static const String apiContentTypeJSON = 'application/json';

  static const String googleAPIKey = AppSecrets.googleAPIKey;

  static const String notificationChannelID = 'zeroonedelivery';
  static const String notificationChannelName = '01 Delivery';
  static const String notificationChannelDescription =
      '01 Delivery app notification channel';
  static const String notificationChannelTicker = 'zeroonedeliveryticker';

  static const int defaultUnsetDateTimeYear = 1800;

  static const String apiDateTimeFormatValue =
      'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';
  static const String apiOnlyDateFormatValue = 'dd-MM-yyyy';
  static const String apiOnlyTimeFormatValue = 'HH:mm';
  static const double dialogBorderRadiusValue = 20;
  // Dialog padding values
  static const double dialogVerticalSpaceValue = 16;
  static const double dialogHalfVerticalSpaceValue = 8;
  static const double dialogHorizontalSpaceValue = 18;
  static const double imageBorderRadiusValue = 14;
  static const double smallBorderRadiusValue = 5;
  static const double auctionGridItemBorderRadiusValue = 20;
  static const double uploadImageButtonBorderRadiusValue = 12;
  static const double defaultBorderRadiusValue = 18;
  static const String userRoleUser = 'owner';
  static const LatLng defaultMapLatLng = LatLng(22.8456, 89.5403);
  static const double unknownLatLongValue = -999;
  static const CameraPosition defaultMapCameraPosition = CameraPosition(
    target: defaultMapLatLng,
    zoom: defaultMapZoomLevel,
  );
  static const double defaultMapZoomLevel = 12.4746;
  static const double borderRadiusValue = 28;

  // messege status
  static const String messageTypeStatusCustomer = 'user';
  static const String messageTypeStatusOwner = 'owner';
  static const String messageTypeStatusDriver = 'driver';
  static const String messageTypeStatusAdmin = 'admin';

  // Vehicle Info Type status
  static const String vehicleDetailsInfoTypeStatusSpecifications =
      'specifications';
  static const String vehicleDetailsInfoTypeStatusFeatures = 'features';
  static const String vehicleDetailsInfoTypeStatusDocuments = 'documents';

  //vehicle list
  static const String vehicleListEnumPending = 'pending';
  static const String vehicleListEnumApproved = 'approved';
  static const String vehicleListEnumCancelled = 'cancelled';
  static const String vehicleListEnumSuspended = 'suspended';

  //Hire Driver list Type
  static const String hireDriverListEnumAccept = 'accepted';
  static const String hireDriverListEnumUserPending = 'user_pending';
  static const String hireDriverListEnumDriverPending = 'driver_pending';
  static const String hireDriverListEnumStarted = 'started';
  static const String hireDriverListEnumComplete = 'completed';
  static const String hireDriverListEnumCancel = 'cancelled';

  static const String orderStatusPending = 'pending';
  static const String orderStatusAccepted = 'accepted';
  static const String orderStatusRejected = 'rejected';
  static const String orderStatusPicked = 'picked';
  static const String orderStatusOnWay = 'on_way';
  static const String orderStatusDelivered = 'delivered';

  static const String paymentMethodCashOnDelivery = 'cash_on_delivery';
  static const String paymentMethodStripe = 'stripe';
  static const String paymentMethodPaypal = 'paypal';
  //----------------------
  static const String hireDriverStatusHourly = 'hourly';
  static const String hireDriverStatusFixed = 'fixed';

  static const String confirmedOrderNotifyTypeConfirmOrder =
      'confirm_order_notify';

  static const String unknown = 'unknown';

  static const String hiveBoxName = 'zero_one_supplies_delivery';
  static const String hiveDefaultLanguageKey = 'default_language';
  static const String languageTranslationKeyCode = '_code';
  static const String fallbackLocale = 'en_US';
  static const String fallbackFrenchLocale = 'fr_FR';

  /// Screen horizontal padding value
  static const double screenPaddingValue = 24;
  // Methods
  static BorderRadius borderRadius(double radiusValue) =>
      BorderRadius.all(Radius.circular(radiusValue));
}
