import 'dart:convert';

import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/about_us_response.dart';
import 'package:one_ride_car_owner/models/api_responses/add_driver_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/car_categories_response.dart';
import 'package:one_ride_car_owner/models/api_responses/car_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/chat_message_list_demo_response.dart';
import 'package:one_ride_car_owner/models/api_responses/chat_message_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/contact_us_response.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/country_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/dashboard_response.dart';
import 'package:one_ride_car_owner/models/api_responses/driver_details_response.dart';
import 'package:one_ride_car_owner/models/api_responses/find_account_response.dart';
import 'package:one_ride_car_owner/models/api_responses/fuel_details_response.dart';
import 'package:one_ride_car_owner/models/api_responses/fuel_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/get_driver_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/get_user_data_response.dart';
import 'package:one_ride_car_owner/models/api_responses/get_wallet_details_response.dart';
import 'package:one_ride_car_owner/models/api_responses/google_map_poly_lines_response.dart';
import 'package:one_ride_car_owner/models/api_responses/hire_driver_details_response.dart';
import 'package:one_ride_car_owner/models/api_responses/hire_driver_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/language_translations_response.dart';
import 'package:one_ride_car_owner/models/api_responses/languages_response.dart';
import 'package:one_ride_car_owner/models/api_responses/login_response.dart';
import 'package:one_ride_car_owner/models/api_responses/maintanance_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/maintenance_details_response.dart';
import 'package:one_ride_car_owner/models/api_responses/message_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/my_subscription_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/nearest_driver_response.dart';
import 'package:one_ride_car_owner/models/api_responses/notification_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/otp_request_response.dart';
import 'package:one_ride_car_owner/models/api_responses/otp_verification_response.dart';
import 'package:one_ride_car_owner/models/api_responses/registration_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_car_elements_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_details_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_history_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_vehicle_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/ride_car_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/ride_details_response.dart';
import 'package:one_ride_car_owner/models/api_responses/subscription_model_response.dart';
import 'package:one_ride_car_owner/models/api_responses/support_text_response.dart';
import 'package:one_ride_car_owner/models/api_responses/user_details_response.dart';
import 'package:one_ride_car_owner/models/api_responses/vehicle_details_response.dart';
import 'package:one_ride_car_owner/models/api_responses/wallet_history_response.dart';
import 'package:one_ride_car_owner/utils/api_client.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class APIRepo {
  static Future<GoogleMapPolyLinesResponse?> getRoutesPolyLines(
      double originLatitude,
      double originLongitude,
      double targetLatitude,
      double targetLongitude) async {
    try {
      await APIHelper.preAPICallCheck();
      // final GetHttpClient apiHttpClient = APIClient.instance.googleMapsAPIClient();
      final Map<String, dynamic> queries = {
        'origin': '$originLatitude,$originLongitude',
        'destination': '$targetLatitude,$targetLongitude',
        'sensor': 'false',
        'key': AppConstants.googleAPIKey,
      };
      final Response response =
          // await apiHttpClient.get('/maps/api/directions/json', query: queries);
          await APIClient.instance.requestGetMethodAsURLEncoded(
              url: '/maps/api/directions/json', queries: queries);
      APIHelper.postAPICallCheck(response);
      final GoogleMapPolyLinesResponse responseModel =
          GoogleMapPolyLinesResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updatePassword(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/user/password',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<GetWalletDetailsResponse?> getWalletDetails() async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/wallet', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final GetWalletDetailsResponse responseModel =
          GetWalletDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<AboutUsResponse?> getAboutUsText() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'slug': 'about_us'};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AboutUsResponse responseModel =
          AboutUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SupportTextResponse?> getSupportText(
      {required String slug}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'slug': slug};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SupportTextResponse responseModel =
          SupportTextResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LanguageTranslationsResponse?>
      fetchLanguageTranslations() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        '/api/language/translations',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LanguageTranslationsResponse responseModel =
          LanguageTranslationsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LanguagesResponse?> fetchLanguages() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        '/api/languages',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LanguagesResponse responseModel =
          LanguagesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> submitReviews(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/review',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ContactUsResponse?> getContactUsDetails() async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'slug': 'contact_us',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ContactUsResponse responseModel =
          ContactUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> postContactUsMessage(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/contact',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> readNotification(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/notification/read',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> readAllNotification(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/notification/read/all',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<FindAccountResponse?> findAccount(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/user/find',
              requestBody:
                  requestBody); /* apiHttpClient.post('/api/user/find',
          body: requestBody, contentType: AppConstants.apiContentType); */
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final FindAccountResponse responseModel =
          FindAccountResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CountryListResponse?> getCountryList() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/countries', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final CountryListResponse responseModel =
          CountryListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> readMessage(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/message',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<NotificationListResponse?> getNotificationList(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/notification/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final NotificationListResponse responseModel =
          NotificationListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> toggleFleetChanges(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsJSONEncoded(
              url: '/api/driver',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<GetUserDataResponse?> getIdUserDetails(String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/user/details',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final GetUserDataResponse responseModel =
          GetUserDataResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<GetUserDataResponse?> getAdminIdUserDetails() async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/user/details', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final GetUserDataResponse responseModel =
          GetUserDataResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<OtpRequestResponse?> requestOTP(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/send-otp',
              requestBody:
                  requestBody) /* apiHttpClient.post('/api/user/send-otp',
          body: requestBody, contentType: AppConstants.apiContentType) */
          ;
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final OtpRequestResponse responseModel =
          OtpRequestResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LoginResponse?> login(Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/login',
              requestBody:
                  requestBody) /* apiHttpClient.post('/api/user/login',
          body: requestBody, contentType: AppConstants.apiContentType) */
          ;
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LoginResponse responseModel =
          LoginResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RegistrationResponse?> registration(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/user/registration', requestBody: requestBody);
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RegistrationResponse responseModel =
          RegistrationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<OtpVerificationResponse?> verifyOTP(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          await APIClient.instance.requestPostMethodAsURLEncoded(
        url: '/api/user/verify-otp',
        requestBody: requestBody,
      ) /*  apiHttpClient.post('/api/user/verify-otp',
          body: requestBody, contentType: AppConstants.apiContentType) */
          ;
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final OtpVerificationResponse responseModel =
          OtpVerificationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> createNewPassword(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/reset-password',
              requestBody:
                  requestBody) /* apiHttpClient.post(
          '/api/user/reset-password',
          body: requestBody,
          contentType: AppConstants.apiContentType) */
          ;
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /* static Future<UserSignUpResponse?> signUp(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient
          .post('api/user/delivery/signup', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final UserSignUpResponse responseModel =
          UserSignUpResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
*/
  static Future<UserDetailsResponse?> getUserDetails({String? token}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/user/',
              headers: token != null
                  ? {'Authorization': 'Bearer $token'}
                  : APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final UserDetailsResponse responseModel =
          UserDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> paymentAcceptHireDriverRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/driver/payment',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> addDriver(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/driver',
              requestBody: requestBody,
              headers: APIHelper
                  .getAuthHeaderMap()) /* apiHttpClient.post(
          '/api/user/reset-password',
          body: requestBody,
          contentType: AppConstants.apiContentType) */
          ;
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<MessageUserListResponse?> getChatUsersList(
      int currentPageNumber, String key) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
        'type': key
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/message/users',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final MessageUserListResponse responseModel =
          MessageUserListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<WalletTransactionHistoryResponse?> getTransactionHistory(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {'page': '$currentPageNumber'};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/wallet/history',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final WalletTransactionHistoryResponse responseModel =
          WalletTransactionHistoryResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> removeDriver(
      Map<String, String> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestDeletMethodAsURLEncoded(
              url: '/api/driver',
              queries: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> paymentAcceptSubscriptionRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/subscription/buy',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CarListResponse?> getVehicleList(
      {required int page, required String key}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page', 'status': key};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/vehicle/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final CarListResponse responseModel =
          CarListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RentHistoryLIstResponse?> getRentHistoryList(
      {required int page, required String key}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page', 'status': key};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/rent/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RentHistoryLIstResponse responseModel =
          RentHistoryLIstResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<HireDriverListResponse?> getHireDriverList(
      {required int page, required String key}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page', 'status': key};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/driver/hire/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final HireDriverListResponse responseModel =
          HireDriverListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ChatMessageListSendResponse?> sendMessage(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/message',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ChatMessageListSendResponse responseModel =
          ChatMessageListSendResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ChatMessageListSendResponse?> sendAdminMessage(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/message/admin',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ChatMessageListSendResponse responseModel =
          ChatMessageListSendResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateRentStatus(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/rent/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> startRentStatus(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/rent/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> topUpWallet(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/wallet/add',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> acceptRequest(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsFormData(
              url: '/api/driver/hire',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateRequest(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/driver/hire',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> rejectRequest(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsFormData(
              url: '/api/driver/hire',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ChatMessageListResponse?> getChatMessageList(
      int currentPageNumber, String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
        'with': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/message/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ChatMessageListResponse responseModel =
          ChatMessageListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ChatMessageListResponse?> getAdminChatMessageList(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {'page': '$currentPageNumber'};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/message/admin',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ChatMessageListResponse responseModel =
          ChatMessageListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<NearestDriverResponse?> getNearestDriverList(
      {required int page, required double lat, required double lng}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        'page': '$page',
        'lat': '$lat',
        'lng': '$lng'
      };

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/driver/nearest',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final NearestDriverResponse responseModel =
          NearestDriverResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<AddedDriverListResponse?> getAddedDriverList(
      {required int page, required String status}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page', 'status': status};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/driver/added',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AddedDriverListResponse responseModel =
          AddedDriverListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<FuelListResponse?> getFuelAddedList(
      {required int page, required String status}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page', 'status': status};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/fleet/fuel/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final FuelListResponse responseModel =
          FuelListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<MaintenanceListResponse?> getMaintenenceAddedList(
      {required int page, required String status}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page', 'status': status};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/fleet/maintenance/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final MaintenanceListResponse responseModel =
          MaintenanceListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<GetDriverListResponse?> getDriver({required String key}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'key': key};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/driver/search',
              queries: key.isNotEmpty ? queries : null,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final GetDriverListResponse responseModel =
          GetDriverListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RentVehicleListResponse?> getRentVehicleList(
      {required int page}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/vehicle/rent/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RentVehicleListResponse responseModel =
          RentVehicleListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

   //-----------------------------------
  static Future<RawAPIResponse?> deleteUserAccount() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response =
          await APIClient.instance.requestDeleteMethodAsURLEncoded(
        url: '/api/user',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RideDetailsResponse?> getRideDetails(
      {required String rideId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': rideId};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/vehicle/ride',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RideDetailsResponse responseModel =
          RideDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<HireDriverDetailsResponse?> getHiredDriverDetails(
      {required String hireDriverId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': hireDriverId};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/driver/hire',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final HireDriverDetailsResponse responseModel =
          HireDriverDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RentDetailsResponse?> fetchRentDetails(
      {required String rentId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': rentId};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/vehicle/rent',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RentDetailsResponse responseModel =
          RentDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RideCarListResponse?> getRideVehicleList(
      {required int page}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/vehicle/ride/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RideCarListResponse responseModel =
          RideCarListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<RawAPIResponse?> editRentActiveStatus(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestPatchMethodAsJSONEncoded(
        url: '/api/vehicle/rent',
        requestBody: requestBodyJson,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<RawAPIResponse?> deletRideActiveStatus(
      Map<String, String> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestDeletMethodAsURLEncoded(
        url: '/api/vehicle/ride',
        queries: requestBody,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<RawAPIResponse?> deletRentActiveStatus(
      Map<String, String> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestDeletMethodAsURLEncoded(
        url: '/api/vehicle/rent',
        queries: requestBody,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<RawAPIResponse?> hireDriver(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestPostMethodAsJSONEncoded(
        url: '/api/driver/hire',
        requestBody: requestBodyJson,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<FuelDetailsResponse?> getFuelDetails(
      {required String fuelItemId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': fuelItemId,
      };

      final Response response =
          await APIClient.instance.requestGetMethodAsJSONEncoded(
        url: '/api/fleet/fuel',
        queries: queries,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final FuelDetailsResponse responseModel =
          FuelDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<SubscriptionModelResponse?> getSubscriptionModel() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response =
          await APIClient.instance.requestGetMethodAsJSONEncoded(
        url: '/api/subscription/list',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SubscriptionModelResponse responseModel =
          SubscriptionModelResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<MySubscriptionListResponse?> getMySubscriptionModel() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response =
          await APIClient.instance.requestGetMethodAsJSONEncoded(
        url: '/api/subscription/history',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final MySubscriptionListResponse responseModel =
          MySubscriptionListResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<RawAPIResponse?> addfuel(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestPostMethodAsJSONEncoded(
        url: '/api/fleet/fuel',
        requestBody: requestBodyJson,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<RawAPIResponse?> addMaintenance(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestPostMethodAsJSONEncoded(
        url: '/api/fleet/maintenance',
        requestBody: requestBodyJson,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<MaintenanceDetailsResponse?> getMaintenanceDetails(
      String maintenanceId) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': maintenanceId};
      final Response response =
          await APIClient.instance.requestGetMethodAsJSONEncoded(
        url: '/api/fleet/maintenance',
        queries: queries,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final MaintenanceDetailsResponse responseModel =
          MaintenanceDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateMaintenance(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestPatchMethodAsJSONEncoded(
        url: '/api/fleet/maintenance',
        requestBody: requestBodyJson,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<RawAPIResponse?> updateFuel(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestPatchMethodAsJSONEncoded(
        url: '/api/fleet/fuel',
        requestBody: requestBodyJson,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<RawAPIResponse?> updateMaintenence(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestPatchMethodAsJSONEncoded(
        url: '/api/fleet/maintenance',
        requestBody: requestBodyJson,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<RawAPIResponse?> deleteFuelRequest(
      Map<String, String> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response =
          await APIClient.instance.requestDeletMethodAsURLEncoded(
        url: '/api/fleet/fuel',
        queries: requestBody,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<RawAPIResponse?> deleteMaintenenceRequest(
      Map<String, String> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response =
          await APIClient.instance.requestDeletMethodAsURLEncoded(
        url: '/api/fleet/maintenance',
        queries: requestBody,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> removeVehicle(
      {required String vehicleId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> requestBody = {
        '_id': vehicleId,
      };

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response =
          await APIClient.instance.requestDeletMethodAsURLEncoded(
        url: '/api/vehicle',
        queries: requestBody,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

//-----------------------------------
  static Future<RawAPIResponse?> editRideActiveStatus(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestPatchMethodAsJSONEncoded(
        url: '/api/vehicle/ride',
        requestBody: requestBodyJson,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<VehicleDetailsResponse?> getVehicleDetails(
      {required String productId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': productId};

      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/vehicle',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final VehicleDetailsResponse responseModel =
          VehicleDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<DriverDetailsResponse?> getDriverDetails(
      {required String driverId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': driverId};

      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/driver',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final DriverDetailsResponse responseModel =
          DriverDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> addVehicle(FormData requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response
          response = /* await APIClient.instance.requestPostMethod(
          url: '/api/vehicle',
          requestBody: requestBody,
          headers: APIHelper.getAuthHeaderMap()); */
          await APIClient.instance.apiClient.post('/api/vehicle',
              body: requestBody,
              contentType: 'multipart/form-data',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {                
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateVehicleDetails(
      FormData requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response
          response = /* await APIClient.instance.requestPostMethod(
          url: '/api/vehicle',
          requestBody: requestBody,
          headers: APIHelper.getAuthHeaderMap()); */
          await APIClient.instance.apiClient.patch('/api/vehicle',
              body: requestBody,
              contentType: 'multipart/form-data',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateUserProfile(dynamic requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      String contentType = 'multipart/form-data';
      if (requestBody is String) {
        contentType = 'application/json';
      }
      final Response
          response = /* await APIClient.instance.requestPostMethod(
          url: '/api/vehicle',
          requestBody: requestBody,
          headers: APIHelper.getAuthHeaderMap()); */
          await APIClient.instance.apiClient.patch('/api/user/',
              body: requestBody,
              contentType: contentType,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CarCategoriesResponse?> getCarCategories() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/vehicle/elements',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final CarCategoriesResponse responseModel =
          CarCategoriesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RentCarElementsResponse?> getRentCarElements(
      {bool patch = false}) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/vehicle/rent/elements',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RentCarElementsResponse responseModel =
          RentCarElementsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RentCarElementsResponse?> getRideCarElements() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/vehicle/ride/elements',
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RentCarElementsResponse responseModel =
          RentCarElementsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> addVehicleToRent(
      Map<String, dynamic> requestJsonString,
      {bool patch = false}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response;
      if (patch) {
        response = await APIClient.instance.requestPatchMethodAsURLEncoded(
            url: '/api/vehicle/rent',
            requestBody: requestJsonString,
            contentType: 'application/json',
            headers: APIHelper.getAuthHeaderMap());
      } else {
        response = await APIClient.instance.requestPostMethodAsURLEncoded(
            url: '/api/vehicle/rent',
            requestBody: requestJsonString,
            contentType: 'application/json',
            headers: APIHelper.getAuthHeaderMap());
      }

      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> addVehicleToRide(
      Map<String, dynamic> requestJsonString, bool patch) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response;
      if (patch) {
        response = await APIClient.instance.requestPatchMethodAsURLEncoded(
            url: '/api/vehicle/ride',
            requestBody: requestJsonString,
            contentType: 'application/json',
            headers: APIHelper.getAuthHeaderMap());
      } else {
        response = await APIClient.instance.requestPostMethodAsURLEncoded(
            url: '/api/vehicle/ride',
            requestBody: requestJsonString,
            contentType: 'application/json',
            headers: APIHelper.getAuthHeaderMap());
      }

      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<DashboardResponse?> getDashboardInfos(
      Map<String, String> queries) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/user/dashboard',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final DashboardResponse responseModel =
          DashboardResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
}
