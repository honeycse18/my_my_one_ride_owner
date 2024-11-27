import 'package:one_ride_car_owner/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class FuelListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<FuelCarListItem> data;

  FuelListResponse({this.error = false, this.msg = '', required this.data});

  factory FuelListResponse.fromJson(Map<String, dynamic> json) {
    return FuelListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            FuelCarListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory FuelListResponse.empty() =>
      FuelListResponse(data: PaginatedDataResponse.empty());
  static FuelListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FuelListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FuelListResponse.empty();
}

class FuelCarListItem {
  String id;
  String owner;
  Vehicle vehicle;
  DateTime startDate;
  DateTime endDate;
  double cost;
  String bearer;
  int startKm;
  int quantity;
  String status;
  String note;
  DateTime createdAt;
  DateTime updatedAt;

  FuelCarListItem({
    this.id = '',
    this.owner = '',
    required this.vehicle,
    required this.startDate,
    required this.endDate,
    this.cost = 0,
    this.bearer = '',
    this.startKm = 0,
    this.quantity = 0,
    this.status = '',
    this.note = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory FuelCarListItem.fromJson(Map<String, dynamic> json) =>
      FuelCarListItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        owner: APIHelper.getSafeStringValue(json['owner']),
        vehicle: Vehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
        cost: APIHelper.getSafeDoubleValue(json['cost']),
        bearer: APIHelper.getSafeStringValue(json['bearer']),
        startKm: APIHelper.getSafeIntValue(json['start_km']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        status: APIHelper.getSafeStringValue(json['status']),
        note: APIHelper.getSafeStringValue(json['note']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'owner': owner,
        'vehicle': vehicle.toJson(),
        'date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'cost': cost,
        'bearer': bearer,
        'start_km': startKm,
        'quantity': quantity,
        'status': status,
        'note': note,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory FuelCarListItem.empty() => FuelCarListItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        startDate: AppComponents.defaultUnsetDateTime,
        endDate: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        vehicle: Vehicle.empty(),
      );
  static FuelCarListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FuelCarListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FuelCarListItem.empty();
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
