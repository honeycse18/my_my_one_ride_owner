import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class DriverRequestUpdateSocketResponse {
  String id;
  DriverRequestSocketDriver driver;
  DriverRequestSocketOwner owner;
  bool fleet;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  DriverRequestUpdateSocketResponse({
    this.id = '',
    required this.driver,
    required this.owner,
    this.fleet = false,
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory DriverRequestUpdateSocketResponse.fromJson(
      Map<String, dynamic> json) {
    return DriverRequestUpdateSocketResponse(
      id: APIHelper.getSafeStringValue(json['_id']),
      driver: DriverRequestSocketDriver.getAPIResponseObjectSafeValue(
          json['driver']),
      owner:
          DriverRequestSocketOwner.getAPIResponseObjectSafeValue(json['owner']),
      fleet: APIHelper.getSafeBoolValue(json['fleet']),
      status: APIHelper.getSafeStringValue(json['status']),
      createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      v: APIHelper.getSafeIntValue(json['__v']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'driver': driver.toJson(),
        'owner': owner.toJson(),
        'fleet': fleet,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory DriverRequestUpdateSocketResponse.empty() =>
      DriverRequestUpdateSocketResponse(
        driver: DriverRequestSocketDriver(),
        owner: DriverRequestSocketOwner(),
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static DriverRequestUpdateSocketResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DriverRequestUpdateSocketResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DriverRequestUpdateSocketResponse.empty();
}

class DriverRequestSocketDriver {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  DriverRequestSocketDriver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory DriverRequestSocketDriver.fromJson(Map<String, dynamic> json) =>
      DriverRequestSocketDriver(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      };

  static DriverRequestSocketDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DriverRequestSocketDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DriverRequestSocketDriver();
}

class DriverRequestSocketOwner {
  String id;
  String uid;
  String name;
  String email;
  String image;

  DriverRequestSocketOwner(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.email = '',
      this.image = ''});

  factory DriverRequestSocketOwner.fromJson(Map<String, dynamic> json) =>
      DriverRequestSocketOwner(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'image': image,
      };

  static DriverRequestSocketOwner getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DriverRequestSocketOwner.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DriverRequestSocketOwner();
}
