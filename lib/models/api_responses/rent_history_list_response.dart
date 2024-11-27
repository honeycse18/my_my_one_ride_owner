import 'package:one_ride_car_owner/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class RentHistoryLIstResponse {
  bool error;
  String msg;
  PaginatedDataResponse<RentHistoryList> data;

  RentHistoryLIstResponse(
      {this.error = false, this.msg = '', required this.data});

  factory RentHistoryLIstResponse.fromJson(Map<String, dynamic> json) {
    return RentHistoryLIstResponse(
      error: json['error'] as bool,
      msg: json['msg'] as String,
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            RentHistoryList.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory RentHistoryLIstResponse.empty() =>
      RentHistoryLIstResponse(data: PaginatedDataResponse.empty());
  static RentHistoryLIstResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentHistoryLIstResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentHistoryLIstResponse.empty();
}

class RentHistoryList {
  String id;
  User user;
  Rent rent;
  Owner owner;
  Driver driver;
  DateTime date;
  String type;
  double rate;
  int quantity;
  double total;
  String paymentMethod;
  String cancelReason;
  String status;
  bool paid;
  DateTime createdAt;
  DateTime updatedAt;
  RentHistoryList({
    this.id = '',
    required this.user,
    required this.rent,
    required this.owner,
    required this.driver,
    required this.date,
    this.type = '',
    this.cancelReason = '',
    this.rate = 0,
    this.quantity = 0,
    this.total = 0,
    this.paymentMethod = '',
    this.status = '',
    this.paid = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RentHistoryList.fromJson(Map<String, dynamic> json) =>
      RentHistoryList(
        id: APIHelper.getSafeStringValue(json['_id']),
        cancelReason: APIHelper.getSafeStringValue(json['cancel_reason']),
        user: User.getAPIResponseObjectSafeValue(json['user']),
        rent: Rent.getAPIResponseObjectSafeValue(json['rent']),
        owner: Owner.getAPIResponseObjectSafeValue(json['owner']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        date: APIHelper.getSafeDateTimeValue(json['date']),
        type: APIHelper.getSafeStringValue(json['type']),
        rate: APIHelper.getSafeDoubleValue(json['rate']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
        status: APIHelper.getSafeStringValue(json['status']),
        paid: APIHelper.getSafeBoolValue(json['paid']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'cancel_reason': cancelReason,
        'user': user.toJson(),
        'rent': rent.toJson(),
        'owner': owner.toJson(),
        'driver': driver.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'type': type,
        'rate': rate,
        'quantity': quantity,
        'total': total,
        'payment_method': paymentMethod,
        'status': status,
        'paid': paid,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory RentHistoryList.empty() => RentHistoryList(
      createdAt: AppComponents.defaultUnsetDateTime,
      date: AppComponents.defaultUnsetDateTime,
      driver: Driver(),
      owner: Owner(),
      rent: Rent(),
      updatedAt: AppComponents.defaultUnsetDateTime,
      user: User());
  static RentHistoryList getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentHistoryList.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentHistoryList.empty();
}

class Driver {
  String id;
  String uid;
  String name;
  String image;

  Driver({this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
      };

  static Driver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Driver.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Driver();
}

class Owner {
  String id;
  String uid;
  String name;
  String image;

  Owner({this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
      };

  static Owner getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Owner.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Owner();
}

class User {
  String id;
  String uid;
  String name;
  String image;

  User({this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
      };

  static User getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? User.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : User();
}

class Rent {
  String? id;
  String? address;

  Rent({this.id, this.address});

  factory Rent.fromJson(Map<String, dynamic> json) => Rent(
        id: APIHelper.getSafeStringValue(json['_id']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'address': address,
      };

  static Rent getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Rent.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Rent();
}
