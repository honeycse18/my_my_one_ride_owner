import 'package:one_ride_car_owner/models/api_responses/rent_car_elements_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class RentDetailsResponse {
  bool error;
  String msg;
  RentDetailsData data;

  RentDetailsResponse({this.error = false, this.msg = '', required this.data});

  factory RentDetailsResponse.fromJson(Map<String, dynamic> json) {
    return RentDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: RentDetailsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory RentDetailsResponse.empty() => RentDetailsResponse(
        data: RentDetailsData.empty(),
      );
  static RentDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentDetailsResponse.empty();
}

class RentDetailsData {
  RentDetailsPrices prices;
  RentDetailsFacilities facilities;
  String id;
  String uid;
  String owner;
  RentCarElementsVehicle vehicle;
  bool hasDriver;
  RentCarElementsDriver driver;
  String address;
  RentDetailsLocation location;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  RentDetailsData({
    required this.prices,
    required this.facilities,
    this.id = '',
    this.uid = '',
    this.owner = '',
    required this.vehicle,
    this.hasDriver = false,
    required this.driver,
    this.address = '',
    required this.location,
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory RentDetailsData.fromJson(Map<String, dynamic> json) =>
      RentDetailsData(
        prices: RentDetailsPrices.getAPIResponseObjectSafeValue(json['prices']),
        facilities: RentDetailsFacilities.getAPIResponseObjectSafeValue(
            json['facilities']),
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        owner: APIHelper.getSafeStringValue(json['owner']),
        vehicle: RentCarElementsVehicle.getAPIResponseObjectSafeValue(
            json['vehicle']),
        hasDriver: APIHelper.getSafeBoolValue(json['has_driver']),
        driver:
            RentCarElementsDriver.getAPIResponseObjectSafeValue(json['driver']),
        address: APIHelper.getSafeStringValue(json['address']),
        location:
            RentDetailsLocation.getAPIResponseObjectSafeValue(json['location']),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        'prices': prices.toJson(),
        'facilities': facilities.toJson(),
        '_id': id,
        'uid': uid,
        'owner': owner,
        'vehicle': vehicle.toJson(),
        'has_driver': hasDriver,
        'driver': driver.toJson(),
        'address': address,
        'location': location,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory RentDetailsData.empty() => RentDetailsData(
      prices: RentDetailsPrices.empty(),
      facilities: RentDetailsFacilities(),
      vehicle: RentCarElementsVehicle(),
      location: RentDetailsLocation(),
      driver: RentCarElementsDriver(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static RentDetailsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentDetailsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentDetailsData.empty();
}

class RentDetailsLocation {
  double lat;
  double lng;

  RentDetailsLocation({this.lat = 0, this.lng = 0});

  factory RentDetailsLocation.fromJson(Map<String, dynamic> json) =>
      RentDetailsLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static RentDetailsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentDetailsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentDetailsLocation();
}

class RentDetailsFacilities {
  bool smoking;
  int luggage;

  RentDetailsFacilities({this.smoking = false, this.luggage = 0});

  factory RentDetailsFacilities.fromJson(Map<String, dynamic> json) =>
      RentDetailsFacilities(
        smoking: APIHelper.getSafeBoolValue(json['smoking']),
        luggage: APIHelper.getSafeIntValue(json['luggage']),
      );

  Map<String, dynamic> toJson() => {
        'smoking': smoking,
        'luggage': luggage,
      };

  static RentDetailsFacilities getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentDetailsFacilities.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentDetailsFacilities();
}

class RentDetailsPrices {
  RentDetailsHourly hourly;
  RentDetailsWeekly weekly;
  RentDetailsMonthly monthly;

  RentDetailsPrices(
      {required this.hourly, required this.weekly, required this.monthly});

  factory RentDetailsPrices.fromJson(Map<String, dynamic> json) =>
      RentDetailsPrices(
        hourly: RentDetailsHourly.getAPIResponseObjectSafeValue(json['hourly']),
        weekly: RentDetailsWeekly.getAPIResponseObjectSafeValue(json['weekly']),
        monthly:
            RentDetailsMonthly.getAPIResponseObjectSafeValue(json['monthly']),
      );

  Map<String, dynamic> toJson() => {
        'hourly': hourly.toJson(),
        'weekly': weekly.toJson(),
        'monthly': monthly.toJson(),
      };

  factory RentDetailsPrices.empty() => RentDetailsPrices(
      hourly: RentDetailsHourly(),
      weekly: RentDetailsWeekly(),
      monthly: RentDetailsMonthly());
  static RentDetailsPrices getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentDetailsPrices.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentDetailsPrices.empty();
}

class RentDetailsHourly {
  bool active;
  int price;

  RentDetailsHourly({this.active = false, this.price = 0});

  factory RentDetailsHourly.fromJson(Map<String, dynamic> json) =>
      RentDetailsHourly(
        active: APIHelper.getSafeBoolValue(json['active']),
        price: APIHelper.getSafeIntValue(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static RentDetailsHourly getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentDetailsHourly.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentDetailsHourly();
}

class RentDetailsWeekly {
  bool active;
  int price;

  RentDetailsWeekly({this.active = false, this.price = 0});

  factory RentDetailsWeekly.fromJson(Map<String, dynamic> json) =>
      RentDetailsWeekly(
        active: APIHelper.getSafeBoolValue(json['active']),
        price: APIHelper.getSafeIntValue(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static RentDetailsWeekly getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentDetailsWeekly.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentDetailsWeekly();
}

class RentDetailsMonthly {
  bool active;
  int price;

  RentDetailsMonthly({this.active = false, this.price = 0});

  factory RentDetailsMonthly.fromJson(Map<String, dynamic> json) =>
      RentDetailsMonthly(
        active: APIHelper.getSafeBoolValue(json['active']),
        price: APIHelper.getSafeIntValue(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static RentDetailsMonthly getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentDetailsMonthly.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentDetailsMonthly();
}
