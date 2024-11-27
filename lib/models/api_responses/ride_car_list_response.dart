import 'package:one_ride_car_owner/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class RideCarListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<RideCarListItems> data;

  RideCarListResponse({this.error = false, this.msg = '', required this.data});

  factory RideCarListResponse.fromJson(Map<String, dynamic> json) {
    return RideCarListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(json['data'],
          docFromJson: (data) =>
              RideCarListItems.getAPIResponseObjectSafeValue(data)),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((data) => data.toJson()),
      };

  factory RideCarListResponse.empty() => RideCarListResponse(
        data: PaginatedDataResponse.empty(),
      );
  static RideCarListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideCarListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideCarListResponse.empty();
}

class RideCarListItems {
  String id;
  String uid;
  RideCarListVehicle vehicle;
  RideCarListDriver driver;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;

  RideCarListItems({
    this.id = '',
    this.uid = '',
    required this.vehicle,
    required this.driver,
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RideCarListItems.fromJson(Map<String, dynamic> json) =>
      RideCarListItems(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        vehicle:
            RideCarListVehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        driver: RideCarListDriver.getAPIResponseObjectSafeValue(json['driver']),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
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
      };

  factory RideCarListItems.empty() => RideCarListItems(
      vehicle: RideCarListVehicle(),
      driver: RideCarListDriver(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static RideCarListItems getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideCarListItems.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideCarListItems.empty();
}

class RideCarListDriver {
  String id;
  String name;
  String phone;
  String email;

  RideCarListDriver(
      {this.id = '', this.name = '', this.phone = '', this.email = ''});

  factory RideCarListDriver.fromJson(Map<String, dynamic> json) =>
      RideCarListDriver(
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

  static RideCarListDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideCarListDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideCarListDriver();
}

class RideCarListVehicle {
  String id;
  String name;
  List<String> images;
  String vehicleNumber;

  RideCarListVehicle(
      {this.id = '',
      this.name = '',
      this.images = const [],
      this.vehicleNumber = ''});

  factory RideCarListVehicle.fromJson(Map<String, dynamic> json) =>
      RideCarListVehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        vehicleNumber: APIHelper.getSafeStringValue(json['vehicle_number']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'images': images,
        'vehicle_number': vehicleNumber,
      };

  static RideCarListVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideCarListVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideCarListVehicle();
}
