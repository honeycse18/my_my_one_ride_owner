import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class SingleImageUploadResponse {
  bool error;
  String msg;
  String data;

  SingleImageUploadResponse(
      {this.error = false, this.msg = '', this.data = ''});

  factory SingleImageUploadResponse.fromJson(Map<String, dynamic> json) {
    return SingleImageUploadResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeStringValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data,
      };

  static SingleImageUploadResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleImageUploadResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleImageUploadResponse();
}
