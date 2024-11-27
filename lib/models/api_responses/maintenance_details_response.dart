import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class MaintenanceDetailsResponse {
  bool error;
  String msg;
  MaintenanceDetailsData data;

  MaintenanceDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory MaintenanceDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MaintenanceDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: MaintenanceDetailsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory MaintenanceDetailsResponse.empty() => MaintenanceDetailsResponse(
        data: MaintenanceDetailsData.empty(),
      );
  static MaintenanceDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MaintenanceDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MaintenanceDetailsResponse.empty();
}

class MaintenanceDetailsData {
  String id;
  String owner;
  MaintenanceDetailsVehicle vehicle;
  DateTime date;
  int cost;
  String bearer;
  List<MaintenanceDetailsPart> parts;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MaintenanceDetailsData({
    this.id = '',
    this.owner = '',
    required this.vehicle,
    required this.date,
    this.cost = 0,
    this.bearer = '',
    this.parts = const [],
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory MaintenanceDetailsData.fromJson(Map<String, dynamic> json) =>
      MaintenanceDetailsData(
        id: APIHelper.getSafeStringValue(json['_id']),
        owner: APIHelper.getSafeStringValue(json['owner']),
        vehicle: MaintenanceDetailsVehicle.getAPIResponseObjectSafeValue(
            json['vehicle']),
        date: APIHelper.getSafeDateTimeValue(json['date']),
        cost: APIHelper.getSafeIntValue(json['cost']),
        bearer: APIHelper.getSafeStringValue(json['bearer']),
        parts: APIHelper.getSafeListValue(json['parts'])
            .map((e) => MaintenanceDetailsPart.getAPIResponseObjectSafeValue(e))
            .toList(),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'owner': owner,
        'vehicle': vehicle.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'cost': cost,
        'bearer': bearer,
        'parts': parts.map((e) => e.toJson()).toList(),
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory MaintenanceDetailsData.empty() => MaintenanceDetailsData(
      vehicle: MaintenanceDetailsVehicle.empty(),
      date: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static MaintenanceDetailsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MaintenanceDetailsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MaintenanceDetailsData.empty();
}

class MaintenanceDetailsVehicle {
  String id;
  String name;
  MaintenanceDetailsCategory category;
  List<String> images;

  MaintenanceDetailsVehicle(
      {this.id = '',
      this.name = '',
      required this.category,
      this.images = const []});

  factory MaintenanceDetailsVehicle.fromJson(Map<String, dynamic> json) =>
      MaintenanceDetailsVehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        category: MaintenanceDetailsCategory.getAPIResponseObjectSafeValue(
            json['category']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'category': category.toJson(),
        'images': images,
      };

  factory MaintenanceDetailsVehicle.empty() => MaintenanceDetailsVehicle(
        category: MaintenanceDetailsCategory(),
      );
  static MaintenanceDetailsVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MaintenanceDetailsVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MaintenanceDetailsVehicle.empty();
}

class MaintenanceDetailsCategory {
  String id;
  String name;

  MaintenanceDetailsCategory({this.id = '', this.name = ''});

  factory MaintenanceDetailsCategory.fromJson(Map<String, dynamic> json) =>
      MaintenanceDetailsCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static MaintenanceDetailsCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MaintenanceDetailsCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MaintenanceDetailsCategory();
}

class MaintenanceDetailsPart {
  String name;
  int quantity;
  int cost;
  String id;

  MaintenanceDetailsPart(
      {this.name = '', this.quantity = 0, this.cost = 0, this.id = ''});

  factory MaintenanceDetailsPart.fromJson(Map<String, dynamic> json) =>
      MaintenanceDetailsPart(
        name: APIHelper.getSafeStringValue(json['name']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        cost: APIHelper.getSafeIntValue(json['cost']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'cost': cost,
        '_id': id,
      };

  static MaintenanceDetailsPart getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MaintenanceDetailsPart.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MaintenanceDetailsPart();
}
