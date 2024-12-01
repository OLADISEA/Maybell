import 'package:flutter/material.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

import '../../main.dart';
import '../../screen/log_in_page/auth_screens/authorization/allow_login_screen.dart';

class NotificationService{
  static Future<void> initializeNotification()async{
    await AwesomeNotifications().initialize(
      null,
        //'resource://drawable/bell',
        [
          NotificationChannel(
              channelGroupKey: 'High_importance_channel',
              channelKey: 'High_importance_channel',
              channelName: 'MAYBELL Notifications',
              channelDescription: 'Notification channel to detect unauthorized user',
              defaultColor: const Color(0XFF905000),
              ledColor: Colors.white,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
              criticalAlerts: true
          ),

        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'High_importance_channel_group',
              channelGroupName: 'Group 1'
          )
        ],
      debug: true
    );


    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async{
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod
    );


  }

  ///use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async{
    debugPrint('onNotificationCreatedMethod');
  }

  ///use this method to detect every time a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async{
    debugPrint('onNotificationDisplayedMethod');
  }

  /// use this method to detect if the user dismissed a notification
 static Future<void> onDismissActionReceivedMethod(ReceivedNotification receivedNotification) async{
    debugPrint('onDismissActionReceivedMethod');
  }

  ///
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async{
    debugPrint('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};
    String socialMediaName = payload["socialMediaName"] ?? ''; // Get socialMediaName from payload
    String username = payload["username"] ?? ''; // Get username from payload
    String loginInfoId = payload["loginInfoId"]??'';
    String phoneModel = payload["phone_model"]??'Unknown device';
    if(payload["navigate"] == "true"){
      MyApp.navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => Authorization(
        socialMediaName: socialMediaName, username: username,loginInfoId:loginInfoId,phoneModel:phoneModel)));
    }
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    required final String socialMediaName,
    required final String username,
    required final String loginInfoId,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async{
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1,
            channelKey:'High_importance_channel',
            title: title,
            body: body,
            actionType: actionType,
            notificationLayout: notificationLayout,
            summary: summary,
            category: category,
            payload: payload,
            bigPicture: bigPicture
        ),
      actionButtons: actionButtons,
      schedule: scheduled? NotificationInterval(
          interval: interval,
          timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
          preciseAlarm: true
      ): null
    );
  }
}