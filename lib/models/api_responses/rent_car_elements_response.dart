import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class RentCarElementsResponse {
  bool error;
  String msg;
  RentCarElementsData data;

  RentCarElementsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory RentCarElementsResponse.fromJson(Map<String, dynamic> json) {
    return RentCarElementsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: RentCarElementsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory RentCarElementsResponse.empty() => RentCarElementsResponse(
        data: RentCarElementsData(),
      );
  static RentCarElementsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentCarElementsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentCarElementsResponse.empty();
}

class RentCarElementsData {
  List<RentCarElementsDriver> drivers;
  List<RentCarElementsVehicle> vehicles;

  RentCarElementsData({this.drivers = const [], this.vehicles = const []});

  factory RentCarElementsData.fromJson(Map<String, dynamic> json) =>
      RentCarElementsData(
        drivers: APIHelper.getSafeListValue(json['drivers'])
            .map((e) => RentCarElementsDriver.getAPIResponseObjectSafeValue(e))
            .toList(),
        vehicles: APIHelper.getSafeListValue(json['vehicles'])
            .map((e) => RentCarElementsVehicle.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'drivers': drivers.map((e) => e.toJson()).toList(),
        'vehicles': vehicles.map((e) => e.toJson()).toList(),
      };

  static RentCarElementsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentCarElementsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentCarElementsData();
}

class RentCarElementsDriver {
  String id;
  String name;
  String uid;
  String image;
  String rent;
  String ride;

  RentCarElementsDriver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.image = '',
    this.rent = '',
    this.ride = '',
  });

  factory RentCarElementsDriver.fromJson(Map<String, dynamic> json) =>
      RentCarElementsDriver(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        image: APIHelper.getSafeStringValue(json['image']),
        name: APIHelper.getSafeStringValue(json['name']),
        rent: APIHelper.getSafeStringValue(json['rent']),
        ride: APIHelper.getSafeStringValue(json['ride']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
        'rent': rent,
        'ride': ride,
      };

  static RentCarElementsDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentCarElementsDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentCarElementsDriver();
}

class RentCarElementsVehicle {
  String id;
  String name;
  String vehicleNumber;
  List<String> images;
  String rent;
  String ride;

  RentCarElementsVehicle(
      {this.id = '',
      this.name = '',
      this.images = const [],
      this.rent = '',
      this.vehicleNumber = '',
      this.ride = ''});

  factory RentCarElementsVehicle.fromJson(Map<String, dynamic> json) =>
      RentCarElementsVehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        vehicleNumber: APIHelper.getSafeStringValue(json['vehicle_number']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        rent: APIHelper.getSafeStringValue(json['rent']),
        ride: APIHelper.getSafeStringValue(json['ride']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'vehicle_number': vehicleNumber,
        'images': images,
        'rent': rent,
        'ride': ride,
      };

  static RentCarElementsVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentCarElementsVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentCarElementsVehicle();
}
