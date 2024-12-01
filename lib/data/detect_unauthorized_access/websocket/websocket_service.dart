import 'dart:async';
import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;
import 'package:web_socket_channel/io.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import '../../repository/user_tokens.dart';
import '../notification_service.dart';

const String mimiApiKey = '2712a10d-32eb-4c50-ba57-dee1f4faddc3';

Future<String?> _loadUserEmail() async {
  final fetchedUsername = await AccessTokenProvider.getUserEmail();
  return fetchedUsername;
}

class WebSocketService {
  //late String userEmail;
  final NotificationService notificationService = NotificationService();
  late IOWebSocketChannel channel;
  final _messageController = StreamController<String>();

  Stream<String> get messageStream => _messageController.stream;

  void initializeWebSocket(String userEmail, String phoneModel) async {
    //this.userEmail = await _loadUserEmail() ?? userEmail;
    print('the user email is $userEmail');
    channel = IOWebSocketChannel.connect(
        'ws://maybell.onrender.com/ws/chat/$mimiApiKey/$userEmail/');

    channel.stream.listen((message) {
      print("listening");
      print(message);
      handleIncomingMessage(message);
    });
  }

  void handleIncomingMessage(String message) {
    _messageController.add(message);
    // Parse JSON message and extract notification data
    Map<String, dynamic> data = json.decode(message);

    String phoneModel = '';
    if (data.containsKey("message")) {
      Map<String, dynamic> messageData = data["message"];
      if (messageData.containsKey("phone_model")) {
        phoneModel = messageData["phone_model"];
        print("Received phone model: $phoneModel");
      }
    }

    String socialMediaName = data["message"]["social_media_name"] ?? 'mimi-chat';
    print('the social media name is $socialMediaName');
    String username = data["message"]["platform_email"] ?? "@thewebalpha";
    String loginInfoId = data["message"]["login_info_id"] ?? '';
    int timestamp = data['timestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    String formattedTime = timeago.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
    String title = data['title'] ?? 'Maybell';
    String body = data['body'] ?? 'A device wants to log into your $socialMediaName account, is this you or \nsomeone you know?';

    NotificationService.showNotification(
        title: title,
        body: body,
        socialMediaName: socialMediaName,
        username: username,
        loginInfoId: loginInfoId,
        payload: {
          "navigate": "true",
          "socialMediaName": socialMediaName,
          "username": username,
          "loginInfoId": loginInfoId,
          "phone_model": phoneModel
        },
        actionButtons: [
          NotificationActionButton(
              key: 'check',
              label: 'Confirm',
              actionType: ActionType.SilentAction
          )
        ],
        notificationLayout: NotificationLayout.Inbox
    );
  }

  void dispose() {
    _messageController.close();
  }



  void displayNotification(String title, String body) async {
    print("Notifications");
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'VIEW',
          label: 'View',
        ),
      ],
    );
    // Set up an on action received method for notification actions

  }




}
