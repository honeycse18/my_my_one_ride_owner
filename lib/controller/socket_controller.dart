import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/chat_message_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/driver_request_update_socket_response.dart';
import 'package:one_ride_car_owner/models/api_responses/new_hire_socket_response.dart';
import 'package:one_ride_car_owner/models/api_responses/new_rent_socket_response.dart';
import 'package:one_ride_car_owner/models/api_responses/rent_status_socket_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  Rx<ChatMessageListItem> newMessageData = ChatMessageListItem.empty().obs;
  Rx<ChatMessageListItem> updatedMessageData = ChatMessageListItem.empty().obs;
  Rx<DriverRequestUpdateSocketResponse> driverRequestUpdateData =
      DriverRequestUpdateSocketResponse.empty().obs;
  Rx<NewRentSocketResponse> newRentSocketData =
      NewRentSocketResponse.empty().obs;
  Rx<RentStatusSocketResponse> rentStatusSocketData =
      RentStatusSocketResponse.empty().obs;
  Rx<HireSocketResponse> hireDetails = HireSocketResponse.empty().obs;

  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder()
          // .setAuth(Helper.getAuthHeaderMap())
          .setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']) // for Flutter or Dart VM
          .build());

  dynamic onNewMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    newMessageData.value = mapData;
    update();
  }

  dynamic onNewAdminMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    newMessageData.value = mapData;
    update();
  }

  dynamic onUpdateMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    updatedMessageData.value = mapData;
    update();
  }

  dynamic onAdminUpdateMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    updatedMessageData.value = mapData;
    update();
  }

  dynamic onNewRent(dynamic data) {
    log(data.toString());
    final NewRentSocketResponse mapData =
        NewRentSocketResponse.getAPIResponseObjectSafeValue(data);
    newRentSocketData.value = mapData;
    update();
  }

  dynamic onRentStatusUpdate(dynamic data) {
    log(data.toString());
    final RentStatusSocketResponse mapData =
        RentStatusSocketResponse.getAPIResponseObjectSafeValue(data);
    rentStatusSocketData.value = mapData;
    update;
  }

  dynamic onDriverRequestUpdate(dynamic data) {
    log(data.toString());
    final DriverRequestUpdateSocketResponse mapData =
        DriverRequestUpdateSocketResponse.getAPIResponseObjectSafeValue(data);
    driverRequestUpdateData.value = mapData;
    update;
  }

  dynamic onHireUpdate(dynamic data) {
    log(data.toString());
    final HireSocketResponse mapData =
        HireSocketResponse.getAPIResponseObjectSafeValue(data);
    hireDetails.value = mapData;
    update();
  }

  void _initSocket() {
    socket.on('new_message', onNewMessages);
    socket.on('new_message', onUpdateMessages);
    socket.on('new_admin_message', onNewAdminMessages);
    socket.on('update_admin_message', onAdminUpdateMessages);
    socket.on('new_rent', onNewRent);
    socket.on('rent_status', onRentStatusUpdate);
    socket.on('hire_update', onHireUpdate);
    socket.on('driver_request', onDriverRequestUpdate);
    socket.onConnect((data) {
      log('data');
      // socket.emit('load_message', <String, dynamic>{'user': chatUser.id});
    });
    /* socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err)); */
    socket.onConnectError((data) {
      log('data connect Error'.toString());
    });
    socket.onConnecting((data) {
      log('data Connecting'.toString());
    });
    socket.onConnectTimeout((data) {
      log('data Connect Timeout');
    });
    socket.onReconnectAttempt((data) {
      log('data Reconnect Attempt');
    });
    socket.onReconnect((data) {
      log('data Reconnect');
    });
    socket.onReconnectFailed((data) {
      log('data Reconnect Failed');
    });
    socket.onReconnectError((data) {
      log('data Reconnect Error');
    });
    socket.onError((data) {
      log('data Error');
    });
    socket.onDisconnect((data) {
      log('data Disconnect');
    });
    socket.onPing((data) {
      log('data Ping');
    });
    socket.onPong((data) {
      log('data Pong');
    });
  }

  @override
  void onInit() {
    if (!socket.connected) {
      _initSocket();
    }
    super.onInit();
  }
}
