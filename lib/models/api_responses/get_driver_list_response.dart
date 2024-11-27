import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class GetDriverListResponse {
  bool error;
  String msg;
  List<GetDriverListItem> data;

  GetDriverListResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory GetDriverListResponse.fromJson(Map<String, dynamic> json) {
    return GetDriverListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => GetDriverListItem.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static GetDriverListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? GetDriverListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : GetDriverListResponse();
}

class GetDriverListItem {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  GetDriverListItem(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = ''});

  factory GetDriverListItem.fromJson(Map<String, dynamic> json) =>
      GetDriverListItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      };

  static GetDriverListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? GetDriverListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : GetDriverListItem();
}
