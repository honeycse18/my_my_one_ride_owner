import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';


class MySubscriptionListResponse {
  bool error;
  String msg;
  List<MySubscriptionItem> data;

  MySubscriptionListResponse({this.error=false, this.msg='', this.data=const[]});

  factory MySubscriptionListResponse.fromJson(Map<String, dynamic> json) {
    return MySubscriptionListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']) ,
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => MySubscriptionItem.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };
      
      
          static MySubscriptionListResponse getAPIResponseObjectSafeValue(
              dynamic unsafeResponseValue) =>
          APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
              ? MySubscriptionListResponse.fromJson(
                  unsafeResponseValue as Map<String, dynamic>)
              : MySubscriptionListResponse();
      
}


class MySubscriptionItem {
  String id;
  String uid;
  Subscription subscription;
  DateTime startDate;
  DateTime endDate;
  int vehicles;
  bool isFleet;
  String type;
  String status;

  MySubscriptionItem({
    this.id = '',
    this.uid = '',
    required this.subscription,
    required this.startDate,
    required this.endDate,
    this.vehicles = 0,
    this.isFleet = false,
    this.type = '',
    this.status = '',
  });

  factory MySubscriptionItem.fromJson(Map<String, dynamic> json) => MySubscriptionItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        subscription:
            Subscription.getAPIResponseObjectSafeValue(json['subscription']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
        vehicles: APIHelper.getSafeIntValue(json['vehicles']),
        isFleet: APIHelper.getSafeBoolValue(json['is_fleet']),
        type: APIHelper.getSafeStringValue(json['type']),
        status: APIHelper.getSafeStringValue(json['status']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'subscription': subscription.toJson(),
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
        'vehicles': vehicles,
        'is_fleet': isFleet,
        'type': type,
        'status': status,
      };

  factory MySubscriptionItem.empty() => MySubscriptionItem(
        endDate: AppComponents.defaultUnsetDateTime,
        startDate: AppComponents.defaultUnsetDateTime,
        subscription: Subscription(),
      );
  static MySubscriptionItem getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MySubscriptionItem.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : MySubscriptionItem.empty();
}

class Subscription {
  String name;

  Subscription({this.name = ''});

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };

  static Subscription getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Subscription.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Subscription();
}

