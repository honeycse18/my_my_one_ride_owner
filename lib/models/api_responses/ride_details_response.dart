import 'package:one_ride_car_owner/models/api_responses/rent_car_elements_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class RideDetailsResponse {
  bool error;
  String msg;
  RideDetailsData data;

  RideDetailsResponse({this.error = false, this.msg = '', required this.data});

  factory RideDetailsResponse.fromJson(Map<String, dynamic> json) {
    return RideDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: RideDetailsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory RideDetailsResponse.empty() => RideDetailsResponse(
        data: RideDetailsData.empty(),
      );
  static RideDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsResponse.empty();
}

class RideDetailsData {
  String id;
  String uid;
  RentCarElementsVehicle vehicle;
  RentCarElementsDriver driver;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  RideDetailsData({
    this.id = '',
    this.uid = '',
    required this.vehicle,
    required this.driver,
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory RideDetailsData.fromJson(Map<String, dynamic> json) =>
      RideDetailsData(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        vehicle: RentCarElementsVehicle.getAPIResponseObjectSafeValue(
            json['vehicle']),
        driver:
            RentCarElementsDriver.getAPIResponseObjectSafeValue(json['driver']),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'vehicle': vehicle.toJson(),
        'driver': driver.toJson(),
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory RideDetailsData.empty() => RideDetailsData(
      vehicle: RentCarElementsVehicle(),
      driver: RentCarElementsDriver(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static RideDetailsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsData.empty();
}

class RideDetailsDriver {
  String id;
  String name;
  String phone;
  String email;

  RideDetailsDriver(
      {this.id = '', this.name = '', this.phone = '', this.email = ''});

  factory RideDetailsDriver.fromJson(Map<String, dynamic> json) =>
      RideDetailsDriver(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'phone': phone,
        'email': email,
      };

  static RideDetailsDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsDriver();
}
