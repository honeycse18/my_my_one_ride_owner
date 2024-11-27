import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/controller/user_notification_screen_controller.dart';
import 'package:one_ride_car_owner/models/api_responses/notification_list_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/notifications_screen_widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserNotificationScreenController>(
        init: UserNotificationScreenController(),
        builder: (controller) => Scaffold(
            backgroundColor: AppColors.mainBg,
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleWidget:  Text(
                  AppLanguageTranslation.notificationsTransKey.toCurrentLanguage,
                ),
                actions: [
                  RawButtonWidget(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 24,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.mainTextColor),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Center(
                          child: Text(
                        AppLanguageTranslation.readAllTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodySemiboldTextStyle
                            .copyWith(color: AppColors.mainTextColor),
                      )),
                    ),
                    onTap: () {
                      controller.readAllNotification();
                      controller.userNotificationPagingController.refresh();
                    },
                  )
                ]),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: () async =>
                      controller.userNotificationPagingController.refresh(),
                  child: PagedListView.separated(
                    pagingController:
                        controller.userNotificationPagingController,
                    builderDelegate: CoreWidgets.pagedChildBuilderDelegate<
                        NotificationListItem>(
                      noItemFoundIndicatorBuilder: (context) {
                        return  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            EmptyScreenWidget(
                              isSVGImage: true,
                              localImageAssetURL:
                                  AppAssetImages.notificationButtonSVGLogoLine,
                              title: AppLanguageTranslation.youHaveTransKey.toCurrentLanguage,
                              shortTitle: '',
                            ),
                          ],
                        );
                      },
                      itemBuilder: (context, item, index) {
                        final notification = item;
                        final previousNotification =
                            controller.previousNotification(index, item);
                        final bool isNotificationDateChanges =
                            controller.isNotificationDateChanges(
                                item, previousNotification);
                        return NotificationWidget(
                          action: notification.action,
                          tittle: notification.title,
                          description: notification.message,
                          dateTime: notification.createdAt,
                          isDateChanged: isNotificationDateChanges,
                          notificationType: notification.action,
                          isRead: notification.read,
                          onTap: () {
                            controller.readNotification(notification.id);
                            controller.userNotificationPagingController
                                .refresh();
                          },
                        );
                      },
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        AppGaps.hGap24,
                  ),
                ),
              ),
            )));
  }
}
