import 'dart:math';

import 'package:vote_app/controller/base_controller.dart';
import 'package:vote_app/networking/providers/notification_api_provider.dart';
import 'package:vote_app/networking/response/notification_response.dart';
import 'package:vote_app/pages/notification_screen.dart';

class NotificationScreenController extends BaseController {
  final NotificationScreenState notificationScreenState;
  NotificationApiProvider _notificationApiProvider;

  NotificationScreenController({this.notificationScreenState});

  Random random = new Random();

  @override
  void init() {
    _notificationApiProvider = NotificationApiProvider();
    _notificationApiProvider
        .getAll()
        .then((response) {
          
        })
        .catchError((error) {});
  }

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
