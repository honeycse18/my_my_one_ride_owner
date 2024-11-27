import 'package:one_ride_car_owner/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class RentVehicleListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<RentVehicleItems> data;

  RentVehicleListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory RentVehicleListResponse.fromJson(Map<String, dynamic> json) {
    return RentVehicleListResponse(
      error: json['error'],
      msg: json['msg'],
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            RentVehicleItems.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory RentVehicleListResponse.empty() =>
      RentVehicleListResponse(data: PaginatedDataResponse.empty());
  static RentVehicleListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentVehicleListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentVehicleListResponse.empty();
}

class RentVehicleItems {
  Prices prices;
  Facilities facilities;
  String id;
  String uid;
  String owner;
  Vehicle vehicle;
  bool hasDriver;
  String address;
  RentVehicleLocation location;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;

  RentVehicleItems({
    required this.prices,
    required this.facilities,
    this.id = '',
    this.uid = '',
    this.owner = '',
    required this.vehicle,
    this.hasDriver = false,
    this.address = '',
    required this.location,
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RentVehicleItems.fromJson(Map<String, dynamic> json) =>
      RentVehicleItems(
        prices: Prices.getAPIResponseObjectSafeValue(json['prices']),
        facilities:
            Facilities.getAPIResponseObjectSafeValue(json['facilities']),
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        owner: APIHelper.getSafeStringValue(json['owner']),
        vehicle: Vehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        hasDriver: APIHelper.getSafeBoolValue(json['has_driver']),
        address: APIHelper.getSafeStringValue(json['address']),
        location:
            RentVehicleLocation.getAPIResponseObjectSafeValue(json['location']),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'prices': prices.toJson(),
        'facilities': facilities.toJson(),
        '_id': id,
        'uid': uid,
        'owner': owner,
        'vehicle': vehicle.toJson(),
        'has_driver': hasDriver,
        'address': address,
        'location': location,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory RentVehicleItems.empty() => RentVehicleItems(
        createdAt: AppComponents.defaultUnsetDateTime,
        facilities: Facilities(),
        prices: Prices.empty(),
        location: RentVehicleLocation(),
        updatedAt: AppComponents.defaultUnsetDateTime,
        vehicle: Vehicle(),
      );
  static RentVehicleItems getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentVehicleItems.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentVehicleItems.empty();
}

class RentVehicleLocation {
  double lat;
  double lng;

  RentVehicleLocation({this.lat = 0, this.lng = 0});

  factory RentVehicleLocation.fromJson(Map<String, dynamic> json) =>
      RentVehicleLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static RentVehicleLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentVehicleLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentVehicleLocation();
}

class Facilities {
  bool smoking;
  int luggage;

  Facilities({this.smoking = false, this.luggage = 0});

  factory Facilities.fromJson(Map<String, dynamic> json) => Facilities(
        smoking: APIHelper.getSafeBoolValue(json['smoking']),
        luggage: APIHelper.getSafeIntValue(json['luggage']),
      );

  Map<String, dynamic> toJson() => {
        'smoking': smoking,
        'luggage': luggage,
      };

  static Facilities getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Facilities.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Facilities();
}

class Prices {
  Hourly hourly;
  Weekly weekly;
  Monthly monthly;

  Prices({required this.hourly, required this.weekly, required this.monthly});

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        hourly: Hourly.getAPIResponseObjectSafeValue(json['hourly']),
        weekly: Weekly.getAPIResponseObjectSafeValue(json['weekly']),
        monthly: Monthly.getAPIResponseObjectSafeValue(json['monthly']),
      );

  Map<String, dynamic> toJson() => {
        'hourly': hourly.toJson(),
        'weekly': weekly.toJson(),
        'monthly': monthly.toJson(),
      };

  factory Prices.empty() => Prices(
        hourly: Hourly(),
        monthly: Monthly(),
        weekly: Weekly(),
      );
  static Prices getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Prices.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Prices.empty();
}

class Weekly {
  bool active;
  double price;

  Weekly({this.active = false, this.price = 0});

  factory Weekly.fromJson(Map<String, dynamic> json) => Weekly(
        active: APIHelper.getSafeBoolValue(json['active']),
        price: APIHelper.getSafeDoubleValue(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static Weekly getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Weekly.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Weekly();
}

class Monthly {
  bool active;
  double price;

  Monthly({this.active = false, this.price = 0});

  factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
        active: APIHelper.getSafeBoolValue(json['active']),
        price: APIHelper.getSafeDoubleValue(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static Monthly getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Monthly.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Monthly();
}

class Hourly {
  bool active;
  double price;

  Hourly({this.active = false, this.price = 0});

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        active: APIHelper.getSafeBoolValue(json['active']),
        price: APIHelper.getSafeDoubleValue(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static Hourly getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Hourly.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Hourly();
}

class Vehicle {
  String id;
  String name;
  List<String> images;
  String vehicleNumber;

  Vehicle(
      {this.id = '',
      this.name = '',
      this.images = const [],
      this.vehicleNumber = ''});

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
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

  static Vehicle getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Vehicle.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Vehicle();
}
