import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class SubscriptionModelResponse {
  bool error;
  String msg;
  List<SubscriptionModelItem> data;

  SubscriptionModelResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory SubscriptionModelResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionModelResponse(
      error: json['error'],
      msg: json['msg'],
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => SubscriptionModelItem.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static SubscriptionModelResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubscriptionModelResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubscriptionModelResponse();
}

class SubscriptionModelItem {
  Price price;
  String id;
  String name;
  int vehicles;
  List<String> features;
  bool isActive;
  bool isFleet;
  DateTime createdAt;
  DateTime updatedAt;

  SubscriptionModelItem({
    required this.price,
    this.id = '',
    this.name = '',
    this.vehicles = 0,
    this.features = const [],
    this.isActive = false,
    this.isFleet = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubscriptionModelItem.fromJson(Map<String, dynamic> json) =>
      SubscriptionModelItem(
        price: Price.getAPIResponseObjectSafeValue(json['price']),
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        vehicles: APIHelper.getSafeIntValue(json['vehicles']),
        features: APIHelper.getSafeListValue(json['features'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        isActive: APIHelper.getSafeBoolValue(json['is_active']),
        isFleet: APIHelper.getSafeBoolValue(json['is_fleet']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'price': price.toJson(),
        '_id': id,
        'name': name,
        'vehicles': vehicles,
        'features': features,
        'is_active': isActive,
        'is_fleet': isFleet,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory SubscriptionModelItem.empty() => SubscriptionModelItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        price: Price(),
      );
  static SubscriptionModelItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubscriptionModelItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubscriptionModelItem.empty();
}

class Price {
  double monthly;
  double yearly;

  Price({this.monthly = 0, this.yearly = 0});

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        monthly: APIHelper.getSafeDoubleValue(json['monthly']),
        yearly: APIHelper.getSafeDoubleValue(json['yearly']),
      );

  Map<String, dynamic> toJson() => {
        'monthly': monthly,
        'yearly': yearly,
      };

  static Price getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Price.fromJson(unsafeResponseValue)
          : Price();
}
