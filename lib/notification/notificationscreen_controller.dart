import 'dart:math';

import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/networking/providers/notification_api_provider.dart';
import 'package:vote_app/networking/response/notification_response.dart';
import 'package:vote_app/notification/notificationscreen_view.dart';

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
          notificationScreenState.addNotifications(response);
        })
        .catchError((error) {
          notificationScreenState.addNotifications(List<NotificationResponse>());
        });
  }

  Future<dynamic> refresh() async {
    _notificationApiProvider
        .getNew()
        .then((response) {
          notificationScreenState.addNotifications(response);
        })
        .catchError((error) {
          
        });
    return null;
  }
}
