import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/socket_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/chat_message_list_demo_response.dart';
import 'package:one_ride_car_owner/models/api_responses/chat_message_list_response.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/get_user_data_response.dart';
import 'package:one_ride_car_owner/models/api_responses/message_list_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AdminChatScreenController extends GetxController {
  RxBool isTooltipShown = false.obs;

  void showTooltip() {
    isTooltipShown.value = true;
  }

  void hideTooltip() {
    isTooltipShown.value = false;
  }

  TextEditingController messageController = TextEditingController();
  ScrollController chatScrollController = ScrollController();
  MessageUserListItem chatUser = MessageUserListItem.empty();
  GetUserData getUser = GetUserData();
  ChatMessageListItem chatMessages = ChatMessageListItem.empty();
  String chatUserId = '';
  // List<ChatMessageListItem> chaMessagetList = [];

  PagingController<int, ChatMessageListItem> chatMessagePagingController =
      PagingController(firstPageKey: 1);

  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder()
          // .setAuth(Helper.getAuthHeaderMap())
          .setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']) // for Flutter or Dart VM
          .build());

  /* ChatMessageListItem? previousChatMessage(int currentIndex) {
    if (currentIndex == 0) {
      return null;
    }
    final previousIndex = currentIndex - 1;
    try {
      return chaMessagetList[previousIndex];
    } catch (e) {
      return null;
    }
  } */
  //------------Get Method----------------

  Future<void> getAdminChatMessageList(int currentPageNumber) async {
    ChatMessageListResponse? response =
        await APIRepo.getAdminChatMessageList(currentPageNumber);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetChatUsersList(response);
  }

  void onSuccessGetChatUsersList(ChatMessageListResponse response) {
    final isLastPage = !response.data.hasNextPage;

    if (response.data.page == 1 && response.data.docs.firstOrNull != null) {
      readMessage(response.data.docs.firstOrNull!.id);
    }
    if (isLastPage) {
      chatMessagePagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    chatMessagePagingController.appendPage(response.data.docs, nextPageNumber);
  }

  //------------post method---------------
  Future<void> sendAdminMessage() async {
    Map<String, dynamic> requestBody = {'message': messageController.text};
    messageController.clear();
    ChatMessageListSendResponse? response =
        await APIRepo.sendAdminMessage(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSucessSendMessage(response);
  }

  _onSucessSendMessage(ChatMessageListSendResponse response) {
    chatMessagePagingController.value.itemList?.insert(0, response.data);
    update();
  }

  //------------post method---------------
  Future<void> readMessage(String id) async {
    Map<String, dynamic> requestBody = {'_id': id, 'read': true};
    messageController.clear();
    RawAPIResponse? response = await APIRepo.readMessage(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSucessReadMessage(response);
  }

  _onSucessReadMessage(RawAPIResponse response) {
    log(response.msg);
  }

  /* String generateID() {
    final objectId = ObjectId();
    return objectId.hexString;
  } */
  /* dynamic onLoadMessages(dynamic data) {
    log('data');
    chatList.insertAll(
        0, ChatMessageListItem.getAPIResponseObjectSafeValue(data));
    update();
    Helper.scrollToStart(chatScrollController);
  } */

  bool isMyChatMessage(ChatMessageListItem chatMessages) {
    final myID = Helper.getUser().id;
    return chatMessages.from.id == myID;
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is String) {
      chatUserId = argument;
      update();
    }
  }

  dynamic onAdminNewMessages(dynamic data) {
    log(data.toString());
    /*  chaMessagetList?.insertAll(
        0, ChatMessageListResponse.getAPIResponseObjectSafeValue(data)); */
    // final message = ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    chatMessagePagingController.value.itemList?.insert(0, data);
    update();
    // chatMessagePagingController.refresh();
  }

  dynamic onAdminUpdateMessages(dynamic data) {
    log(data.toString());
  }

  @override
  void onInit() {
    _getScreenParameter();
    SocketController socketController = Get.find<SocketController>();

    socketController.newMessageData.listen((p0) {
      onAdminNewMessages(p0);
      // readMessage(p0.id);
    });
    socketController.updatedMessageData.listen((p0) {
      onAdminUpdateMessages(p0);
      // readMessage(p0.id);
    });
    // TODO: implement onInit
    chatMessagePagingController.addPageRequestListener((pageKey) {
      getAdminChatMessageList(pageKey);
    });
    // readMessage(chatMessagePagingController.itemList?);

    super.onInit();
  }

  /* @override
  void onClose() {
    // TODO: implement onClose
    // socket.disconnect();
    // socket.dispose();
    super.onClose();
  } */
}
