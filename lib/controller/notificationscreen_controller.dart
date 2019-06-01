import 'dart:math';

import 'package:vote_app/networking/response/notification_response.dart';
import 'package:vote_app/pages/notification_screen.dart';

class NotificationScreenController {
  final NotificationScreenState notificationScreenState;

  NotificationScreenController({this.notificationScreenState});

  Random random = new Random();

  Future<dynamic> refresh() async {
    //notifications = List<NotificationResponse>();
    notificationScreenState.addNotificationItem(NotificationResponse(
          id: random.nextInt(1000),
          message: random.nextInt(1000).toString(),
          notType: "",
          actions: ["join"]));
    return null;
  }
}