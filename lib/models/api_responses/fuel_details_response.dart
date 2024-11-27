import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class FuelDetailsResponse {
  bool error;
  String msg;
  FuelDetailsData data;

  FuelDetailsResponse({this.error = false, this.msg = '', required this.data});

  factory FuelDetailsResponse.fromJson(Map<String, dynamic> json) {
    return FuelDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: FuelDetailsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory FuelDetailsResponse.empty() => FuelDetailsResponse(
        data: FuelDetailsData.empty(),
      );
  static FuelDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FuelDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FuelDetailsResponse.empty();
}

class FuelDetailsData {
  String id;
  String owner;
  FuelDetailsVehicle vehicle;
  DateTime startDate;
  int quantity;
  int cost;
  String bearer;
  int startKm;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  FuelDetailsData({
    this.id = '',
    this.owner = '',
    required this.vehicle,
    required this.startDate,
    this.quantity = 0,
    this.cost = 0,
    this.bearer = '',
    this.startKm = 0,
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory FuelDetailsData.fromJson(Map<String, dynamic> json) =>
      FuelDetailsData(
        id: APIHelper.getSafeStringValue(json['_id']),
        owner: APIHelper.getSafeStringValue(json['owner']),
        vehicle:
            FuelDetailsVehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        cost: APIHelper.getSafeIntValue(json['cost']),
        bearer: APIHelper.getSafeStringValue(json['bearer']),
        startKm: APIHelper.getSafeIntValue(json['start_km']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'owner': owner,
        'vehicle': vehicle.toJson(),
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'quantity': quantity,
        'cost': cost,
        'bearer': bearer,
        'start_km': startKm,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory FuelDetailsData.empty() => FuelDetailsData(
      vehicle: FuelDetailsVehicle.empty(),
      startDate: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static FuelDetailsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FuelDetailsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FuelDetailsData.empty();
}

class FuelDetailsVehicle {
  String id;
  String name;
  FuelDetailsCategory category;
  List<String> images;

  FuelDetailsVehicle(
      {this.id = '',
      this.name = '',
      required this.category,
      this.images = const []});

  factory FuelDetailsVehicle.fromJson(Map<String, dynamic> json) =>
      FuelDetailsVehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        category:
            FuelDetailsCategory.getAPIResponseObjectSafeValue(json['category']),
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

  factory FuelDetailsVehicle.empty() => FuelDetailsVehicle(
        category: FuelDetailsCategory(),
      );
  static FuelDetailsVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FuelDetailsVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FuelDetailsVehicle.empty();
}

class FuelDetailsCategory {
  String id;
  String name;

  FuelDetailsCategory({this.id = '', this.name = ''});

  factory FuelDetailsCategory.fromJson(Map<String, dynamic> json) =>
      FuelDetailsCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static FuelDetailsCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FuelDetailsCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FuelDetailsCategory();
}
