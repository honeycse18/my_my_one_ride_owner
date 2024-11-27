import 'package:one_ride_car_owner/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class MaintenanceListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<MaintenanceListItem> data;

  MaintenanceListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory MaintenanceListResponse.fromJson(Map<String, dynamic> json) {
    return MaintenanceListResponse(
      error: json['error'] as bool,
      msg: json['msg'] as String,
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            MaintenanceListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory MaintenanceListResponse.empty() =>
      MaintenanceListResponse(data: PaginatedDataResponse.empty());
  static MaintenanceListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MaintenanceListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MaintenanceListResponse.empty();
}

class MaintenanceListItem {
  String id;
  String owner;
  Vehicle vehicle;
  DateTime date;
  double cost;
  String bearer;
  List<Part> parts;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  MaintenanceListItem({
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
  });

  factory MaintenanceListItem.fromJson(Map<String, dynamic> json) =>
      MaintenanceListItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        owner: APIHelper.getSafeStringValue(json['owner']),
        vehicle: Vehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        date: APIHelper.getSafeDateTimeValue(json['date']),
        cost: APIHelper.getSafeDoubleValue(json['cost']),
        bearer: APIHelper.getSafeStringValue(json['bearer']),
        parts: APIHelper.getSafeListValue(json['parts'])
            .map((e) => Part.getAPIResponseObjectSafeValue(e))
            .toList(),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
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
      };

  factory MaintenanceListItem.empty() => MaintenanceListItem(
      createdAt: AppComponents.defaultUnsetDateTime,
      date: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime,
      vehicle: Vehicle.empty());
  static MaintenanceListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MaintenanceListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MaintenanceListItem.empty();
}

class Vehicle {
  String id;
  String name;
  Category category;
  List<String> images;

  Vehicle(
      {this.id = '',
      this.name = '',
      required this.category,
      this.images = const []});

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        category: Category.getAPIResponseObjectSafeValue(json['category']),
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

  factory Vehicle.empty() => Vehicle(
        category: Category(),
      );
  static Vehicle getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Vehicle.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Vehicle.empty();
}

class Category {
  String id;
  String name;

  Category({this.id = '', this.name = ''});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static Category getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Category.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Category();
}

class Part {
  String name;
  int quantity;
  double cost;
  String id;

  Part({this.name = '', this.quantity = 0, this.cost = 0, this.id = ''});

  factory Part.fromJson(Map<String, dynamic> json) => Part(
        name: APIHelper.getSafeStringValue(json['name']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        cost: APIHelper.getSafeDoubleValue(json['cost']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'cost': cost,
        '_id': id,
      };

  static Part getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Part.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Part();
}
