import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/message_list_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/message_list_response.dart';

import 'package:one_ride_car_owner/models/enums.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/Tab_list_screen_widget.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/chat_list_widget.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageListScreenController>(
        init: MessageListScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              resizeToAvoidBottomInset: false,
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: false,
                titleWidget: Text(
                  AppLanguageTranslation.messageTransKey.toCurrentLanguage,
                  style: AppTextStyles.titleBoldTextStyle,
                ),
                leading: Center(
                  child: IconButtonWidget(
                    backgroundColor: AppColors.appBarIconTextColor,
                    onTap: () {
                      if (ZoomDrawer.of(context)!.isOpen()) {
                        ZoomDrawer.of(context)!.close();
                      } else {
                        ZoomDrawer.of(context)!.open();
                      }
                    },
                    child: const SizedBox(
                        height: 24,
                        width: 24,
                        child: SvgPictureAssetWidget(
                            AppAssetImages.menuButtonSVGLogoLine,
                            color: AppColors.mainTextColor)),
                  ),
                ),
                actions: [
                  Center(
                    child: IconButtonWidget(
                      backgroundColor: AppColors.appBarIconTextColor,
                      onTap: () {
                        Get.toNamed(AppPageNames.notificationScreen,
                            arguments: true);
                      },
                      child: const SizedBox(
                          height: 24,
                          width: 24,
                          child: SvgPictureAssetWidget(
                              AppAssetImages.notificationButtonSVGLogoLine,
                              color: AppColors.mainTextColor)),
                    ),
                  ),
                  AppGaps.wGap24
                ],
              ),
              body: SafeArea(
                child: ScaffoldBodyWidget(
                    child: RefreshIndicator(
                  onRefresh: () async =>
                      controller.chatUserPagingController.refresh(),
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(child: AppGaps.hGap10),
                      SliverToBoxAdapter(
                        child: SizedBox(
                            height: 50,
                            child: Obx(() => SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      TabStatusWidget(
                                        text: MessageTypeStatus
                                            .driver.stringValueForView,
                                        isSelected:
                                            controller.messageTypeTab.value ==
                                                MessageTypeStatus.driver,
                                        onTap: () {
                                          controller.onTabTap(
                                              MessageTypeStatus.driver);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: MessageTypeStatus
                                            .customer.stringValueForView,
                                        isSelected:
                                            controller.messageTypeTab.value ==
                                                MessageTypeStatus.customer,
                                        onTap: () {
                                          controller.onTabTap(
                                              MessageTypeStatus.customer);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: MessageTypeStatus
                                            .owner.stringValueForView,
                                        isSelected:
                                            controller.messageTypeTab.value ==
                                                MessageTypeStatus.owner,
                                        onTap: () {
                                          controller.onTabTap(
                                              MessageTypeStatus.owner);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: MessageTypeStatus
                                            .admin.stringValueForView,
                                        isSelected:
                                            controller.messageTypeTab.value ==
                                                MessageTypeStatus.admin,
                                        onTap: () {
                                          controller.onTabTap(
                                              MessageTypeStatus.admin);
                                        },
                                      ),
                                    ],
                                  ),
                                ))),
                      ),
                      const SliverToBoxAdapter(child: AppGaps.hGap10),
                      Obx(() {
                        switch (controller.messageTypeTab.value) {
                          case MessageTypeStatus.driver:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.chatUserPagingController,
                              builderDelegate: PagedChildBuilderDelegate<
                                      MessageUserListItem>(
                                  noItemsFoundIndicatorBuilder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                        //-----------------------
                                        localImageAssetURL:
                                            AppAssetImages.confirmIconImage,
                                        title: AppLanguageTranslation
                                            .noChatHistoryTransKey
                                            .toCurrentLanguage,
                                        shortTitle: AppLanguageTranslation
                                            .noMessageTransKey
                                            .toCurrentLanguage)
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final MessageUserListItem chatUsers = item;
                                return ChatListWidget(
                                  mine: chatUsers.mine,
                                  read: chatUsers.read,
                                  onTap: () async {
                                    await Get.toNamed(AppPageNames.chatScreen,
                                        arguments: chatUsers.id);
                                    controller.chatUserPagingController
                                        .refresh();
                                  },
                                  datetime: chatUsers.createdAt,
                                  image: chatUsers.user.image,
                                  message: chatUsers.message,
                                  name: chatUsers.user.name,
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );

                          case MessageTypeStatus.customer:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.chatUserPagingController,
                              builderDelegate: PagedChildBuilderDelegate<
                                      MessageUserListItem>(
                                  noItemsFoundIndicatorBuilder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                        //-----------------------
                                        localImageAssetURL:
                                            AppAssetImages.confirmIconImage,
                                        title: AppLanguageTranslation
                                            .noChatHistoryTransKey
                                            .toCurrentLanguage,
                                        shortTitle: AppLanguageTranslation
                                            .noMessageTransKey
                                            .toCurrentLanguage)
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final MessageUserListItem chatUsers = item;
                                return ChatListWidget(
                                  mine: chatUsers.mine,
                                  read: chatUsers.read,
                                  onTap: () async {
                                    await Get.toNamed(AppPageNames.chatScreen,
                                        arguments: chatUsers.id);
                                    controller.chatUserPagingController
                                        .refresh();
                                  },
                                  datetime: chatUsers.createdAt,
                                  image: chatUsers.user.image,
                                  message: chatUsers.message,
                                  name: chatUsers.user.name,
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );
                          case MessageTypeStatus.owner:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.chatUserPagingController,
                              builderDelegate: PagedChildBuilderDelegate<
                                      MessageUserListItem>(
                                  noItemsFoundIndicatorBuilder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                        //-----------------------
                                        localImageAssetURL:
                                            AppAssetImages.confirmIconImage,
                                        title: AppLanguageTranslation
                                            .noChatHistoryTransKey
                                            .toCurrentLanguage,
                                        shortTitle: AppLanguageTranslation
                                            .noMessageTransKey
                                            .toCurrentLanguage)
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final MessageUserListItem chatUsers = item;
                                return ChatListWidget(
                                  mine: chatUsers.mine,
                                  read: chatUsers.read,
                                  onTap: () async {
                                    await Get.toNamed(AppPageNames.chatScreen,
                                        arguments: chatUsers.id);
                                    controller.chatUserPagingController
                                        .refresh();
                                  },
                                  datetime: chatUsers.createdAt,
                                  image: chatUsers.user.image,
                                  message: chatUsers.message,
                                  name: chatUsers.user.name,
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );
                          case MessageTypeStatus.admin:
                            return const SliverToBoxAdapter(
                              child: Text(''),
                            );
                        }
                      })
                    ],
                  ),
                )),
              ),
            ));
  }
}
