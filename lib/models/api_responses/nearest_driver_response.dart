import 'package:one_ride_car_owner/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class NearestDriverResponse {
  bool error;
  String msg;
  PaginatedDataResponse<NearestDriverList> data;

  NearestDriverResponse(
      {this.error = false, this.msg = '', required this.data});

  factory NearestDriverResponse.fromJson(Map<String, dynamic> json) {
    return NearestDriverResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            NearestDriverList.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory NearestDriverResponse.empty() => NearestDriverResponse(
        data: PaginatedDataResponse.empty(),
      );
  static NearestDriverResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestDriverResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestDriverResponse.empty();
}

class NearestDriverList {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;
  String address;
  NearestDriverLocation location;
  double rate;

  NearestDriverList(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = '',
      this.address = '',
      required this.location,
      this.rate = 0});

  factory NearestDriverList.fromJson(Map<String, dynamic> json) =>
      NearestDriverList(
          id: APIHelper.getSafeStringValue(json['_id']),
          uid: APIHelper.getSafeStringValue(json['uid']),
          name: APIHelper.getSafeStringValue(json['name']),
          phone: APIHelper.getSafeStringValue(json['phone']),
          email: APIHelper.getSafeStringValue(json['email']),
          image: APIHelper.getSafeStringValue(json['image']),
          address: APIHelper.getSafeStringValue(json['address']),
          location: NearestDriverLocation.getAPIResponseObjectSafeValue(
              json['location']),
          rate: APIHelper.getSafeDoubleValue(json['rate']));

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
        'address': address,
        'location': location.toJson(),
        'rate': rate
      };

  factory NearestDriverList.empty() => NearestDriverList(
        location: NearestDriverLocation(),
      );
  static NearestDriverList getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestDriverList.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestDriverList.empty();
}

class NearestDriverLocation {
  double lat;
  double lng;

  NearestDriverLocation({this.lat = 0, this.lng = 0});

  factory NearestDriverLocation.fromJson(Map<String, dynamic> json) =>
      NearestDriverLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static NearestDriverLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestDriverLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestDriverLocation();
}
