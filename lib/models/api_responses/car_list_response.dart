import 'package:one_ride_car_owner/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class CarListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<VehicleListItem> data;

  CarListResponse({this.error = false, this.msg = '', required this.data});

  factory CarListResponse.fromJson(Map<String, dynamic> json) {
    return CarListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            VehicleListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory CarListResponse.empty() => CarListResponse(
        data: PaginatedDataResponse.empty(),
      );
  static CarListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CarListResponse.empty();
}

class VehicleListItem {
  String id;
  String uid;
  CarListOwner owner;
  String name;
  CarListCategory category;
  String model;
  String year;
  List<String> images;
  String maxPower;
  String maxSpeed;
  int capacity;
  String color;
  String fuelType;
  int mileage;
  String gearType;
  bool ac;
  String vehicleNumber;
  List<String> documents;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  VehicleListItem({
    this.id = '',
    this.uid = '',
    required this.owner,
    this.name = '',
    required this.category,
    this.model = '',
    this.year = '',
    this.images = const [],
    this.maxPower = '',
    this.maxSpeed = '',
    this.capacity = 0,
    this.color = '',
    this.fuelType = '',
    this.mileage = 0,
    this.gearType = '',
    this.ac = false,
    this.vehicleNumber = '',
    this.documents = const [],
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleListItem.fromJson(Map<String, dynamic> json) =>
      VehicleListItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        owner: CarListOwner.getAPIResponseObjectSafeValue(
            json['owner'] ),
        name: APIHelper.getSafeStringValue(json['name']),
        category: CarListCategory.getAPIResponseObjectSafeValue(
            json['category']),
        model: APIHelper.getSafeStringValue(json['model']),
        year: APIHelper.getSafeStringValue(json['year']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        maxPower: APIHelper.getSafeStringValue(json['max_power']),
        maxSpeed: APIHelper.getSafeStringValue(json['max_speed']),
        capacity: APIHelper.getSafeIntValue(json['capacity']),
        color: APIHelper.getSafeStringValue(json['color']),
        fuelType: APIHelper.getSafeStringValue(json['fuel_type']),
        mileage: APIHelper.getSafeIntValue(json['mileage']),
        gearType: APIHelper.getSafeStringValue(json['gear_type']),
        ac: APIHelper.getSafeBoolValue(json['ac']),
        vehicleNumber: APIHelper.getSafeStringValue(json['vehicle_number']),
        documents: APIHelper.getSafeListValue(json['documents'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'owner': owner.toJson(),
        'name': name,
        'category': category.toJson(),
        'model': model,
        'year': year,
        'images': images,
        'max_power': maxPower,
        'max_speed': maxSpeed,
        'capacity': capacity,
        'color': color,
        'fuel_type': fuelType,
        'mileage': mileage,
        'gear_type': gearType,
        'ac': ac,
        'vehicle_number': vehicleNumber,
        'documents': documents,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory VehicleListItem.empty() => VehicleListItem(
      owner: CarListOwner(),
      category: CarListCategory(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static VehicleListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VehicleListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : VehicleListItem.empty();
}

class CarListCategory {
  String id;
  String uid;
  String name;

  CarListCategory({this.id = '', this.uid = '', this.name = ''});

  factory CarListCategory.fromJson(Map<String, dynamic> json) =>
      CarListCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
      };

  static CarListCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarListCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CarListCategory();
}

class CarListOwner {
  String id;
  String uid;
  String name;
  String phone;
  String email;

  CarListOwner(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = ''});

  factory CarListOwner.fromJson(Map<String, dynamic> json) => CarListOwner(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
      };

  static CarListOwner getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarListOwner.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : CarListOwner();
}
