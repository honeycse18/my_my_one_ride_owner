import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class UserDetailsResponse {
  bool error;
  String msg;
  UserDetailsData data;

  UserDetailsResponse({this.error = false, this.msg = '', required this.data});

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: UserDetailsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory UserDetailsResponse.empty() => UserDetailsResponse(
        data: UserDetailsData.empty(),
      );
  static UserDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsResponse.empty();
}

class UserDetailsData {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;
  String role;
  String address;
  UserDetailsLocation location;
  UserDetailsCountry country;
  Currency currency;
  Subscription subscription;

  UserDetailsData({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
    this.role = '',
    this.address = '',
    required this.location,
    required this.country,
    required this.currency,
    required this.subscription,
  });

  factory UserDetailsData.fromJson(Map<String, dynamic> json) =>
      UserDetailsData(
          id: APIHelper.getSafeStringValue(json['_id']),
          uid: APIHelper.getSafeStringValue(json['uid']),
          name: APIHelper.getSafeStringValue(json['name']),
          phone: APIHelper.getSafeStringValue(json['phone']),
          email: APIHelper.getSafeStringValue(json['email']),
          image: APIHelper.getSafeStringValue(json['image']),
          role: APIHelper.getSafeStringValue(json['role']),
          address: APIHelper.getSafeStringValue(json['address']),
          subscription:
              Subscription.getAPIResponseObjectSafeValue(json['subscription']),
          location: UserDetailsLocation.getAPIResponseObjectSafeValue(
              json['location']),
          country:
              UserDetailsCountry.getAPIResponseObjectSafeValue(json['country']),
          currency: Currency.getAPIResponseObjectSafeValue(json['currency']));

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
        'role': role,
        'address': address,
        'location': location.toJson(),
        'currency': currency.toJson(),
        'country': country.toJson(),
        'subscription': subscription.toJson(),
      };

  factory UserDetailsData.empty() => UserDetailsData(
      location: UserDetailsLocation(),
      country: UserDetailsCountry(),
      subscription: Subscription.empty(),
      currency: Currency());
  static UserDetailsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsData.empty();

  bool isEmpty() => id.isEmpty;
}

class Subscription {
  String id;
  SubscriptionName subscriptionName;
  DateTime startDate;
  DateTime endDate;
  int vehicles;
  bool isFleet;

  Subscription({
    this.id = '',
    required this.subscriptionName,
    required this.startDate,
    required this.endDate,
    this.vehicles = 0,
    this.isFleet = false,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: APIHelper.getSafeStringValue(json['_id']),
        subscriptionName: SubscriptionName.getAPIResponseObjectSafeValue(
            json['subscription']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
        vehicles: APIHelper.getSafeIntValue(json['vehicles']),
        isFleet: APIHelper.getSafeBoolValue(json['is_fleet']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'subscription': subscriptionName.toJson(),
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
        'vehicles': vehicles,
        'is_fleet': isFleet,
      };

  factory Subscription.empty() => Subscription(
        endDate: AppComponents.defaultUnsetDateTime,
        startDate: AppComponents.defaultUnsetDateTime,
        subscriptionName: SubscriptionName(),
      );
  static Subscription getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Subscription.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Subscription.empty();
}

class SubscriptionName {
  String id;
  String name;

  SubscriptionName({this.id = '', this.name = ''});

  factory SubscriptionName.fromJson(Map<String, dynamic> json) =>
      SubscriptionName(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static SubscriptionName getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubscriptionName.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubscriptionName();
}

class UserDetailsLocation {
  double lat;
  double lng;

  UserDetailsLocation({
    this.lat = 0,
    this.lng = 0,
  });

  factory UserDetailsLocation.fromJson(Map<String, dynamic> json) =>
      UserDetailsLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static UserDetailsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsLocation();
}

class Currency {
  String name;
  String code;
  String symbol;

  Currency({this.name = '', this.code = '', this.symbol = ''});

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: APIHelper.getSafeStringValue(json['name']),
        code: APIHelper.getSafeStringValue(json['code']),
        symbol: APIHelper.getSafeStringValue(json['symbol']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'code': code,
        'symbol': symbol,
      };

  static Currency getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Currency.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Currency();
}

class UserDetailsCountry {
  String id;
  String name;
  String code;

  UserDetailsCountry({this.id = '', this.name = '', this.code = ''});

  factory UserDetailsCountry.fromJson(Map<String, dynamic> json) =>
      UserDetailsCountry(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        code: APIHelper.getSafeStringValue(json['code']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
      };

  static UserDetailsCountry getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsCountry.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsCountry();
}
