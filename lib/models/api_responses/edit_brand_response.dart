import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class EditActiveStatucResponse {
  bool error;
  String msg;

  EditActiveStatucResponse({this.error = false, this.msg = ''});

  factory EditActiveStatucResponse.fromJson(Map<String, dynamic> json) {
    return EditActiveStatucResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
      };
  static EditActiveStatucResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? EditActiveStatucResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : EditActiveStatucResponse();
}
