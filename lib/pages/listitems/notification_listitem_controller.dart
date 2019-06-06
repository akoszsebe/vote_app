import 'package:vote_app/controller/base_controller.dart';
import 'package:vote_app/networking/providers/group_api_provider.dart';
import 'package:vote_app/pages/listitems/notification_listitem.dart';

class NotificationListItemController extends BaseController {
  final NotificationListItemState notificationListItemState;

  NotificationListItemController({this.notificationListItemState});

  void joinGroup(int id) {
    GroupApiProvider groupApiProvider = GroupApiProvider();
    groupApiProvider.accept(id).then((response) {
     notificationListItemState.accepted();
    }).catchError((error) {
      notificationListItemState.onError(error);
    });
  }

  void notJoinGroup(int id) {
    GroupApiProvider groupApiProvider = GroupApiProvider();
    groupApiProvider.reject(id).then((response) {
      notificationListItemState.rejected();
    }).catchError((error) {
     notificationListItemState.onError(error);
    });
  }
}