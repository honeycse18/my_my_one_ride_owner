import 'package:one_ride_car_owner/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class AddedDriverListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<AddedDriverListItem> data;

  AddedDriverListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory AddedDriverListResponse.fromJson(Map<String, dynamic> json) {
    return AddedDriverListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            AddedDriverListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory AddedDriverListResponse.empty() => AddedDriverListResponse(
        data: PaginatedDataResponse.empty(),
      );
  static AddedDriverListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AddedDriverListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AddedDriverListResponse.empty();
}

class AddedDriverListItem {
  String id;
  Driver driver;
  String owner;
  bool fleet;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  AddedDriverListItem({
    this.id = '',
    required this.driver,
    this.owner = '',
    this.status = '',
    this.fleet = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddedDriverListItem.fromJson(Map<String, dynamic> json) =>
      AddedDriverListItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        owner: APIHelper.getSafeStringValue(json['owner']),
        status: APIHelper.getSafeStringValue(json['status']),
        fleet: APIHelper.getSafeBoolValue(json['fleet']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'driver': driver.toJson(),
        'owner': owner,
        'status': status,
        'fleet': fleet,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory AddedDriverListItem.empty() => AddedDriverListItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        driver: Driver(),
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static AddedDriverListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AddedDriverListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AddedDriverListItem.empty();
}

class Driver {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  Driver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
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

  static Driver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Driver.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Driver();
}
