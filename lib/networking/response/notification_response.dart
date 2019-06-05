import 'package:vote_app/utils/utils.dart';

class NotificationResponse {
  int id;
  NotType notType;
  String message;
  List<NotAction> actions;

  NotificationResponse({this.id, this.notType, this.message, this.actions});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      new NotificationResponse(
        id: json["id"],
        notType: notTypeValues.map[json["not_type"]],
        message: json["message"],
        actions: new List<NotAction>.from(json["actions"].map((x) => notActionValues.map[x])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "not_type": notTypeValues.reverse[notType],
        "message": message,
        "actions": actions.map((f)=> notActionValues.reverse[f]).toList()
      };
}

enum NotType {
  NOT_GROUP_INVITE,
  NOT_GROUP_REMOVE,
  NOT_GROUP_UPDATE,
  NOT_GROUP_DELETE,
  NOT_VOTE_UPCOMING,
  NOT_VOTE_UPDATED,
  NOT_VOTE_DELETED
}

final notTypeValues = new EnumValues({
  "NOT_GROUP_INVITE": NotType.NOT_GROUP_INVITE,
  "NOT_GROUP_REMOVE": NotType.NOT_GROUP_REMOVE,
  "NOT_GROUP_UPDATE": NotType.NOT_GROUP_UPDATE,
  "NOT_GROUP_DELETE": NotType.NOT_GROUP_DELETE,
  "NOT_VOTE_UPCOMING": NotType.NOT_VOTE_UPCOMING,
  "NOT_VOTE_UPDATED": NotType.NOT_VOTE_UPDATED,
  "NOT_VOTE_DELETED": NotType.NOT_VOTE_DELETED
});

enum NotAction { 
  ACTION_OPEN, 
  ACTION_ACCEPT, 
  ACTION_DECLINE 
  }

final notActionValues = new EnumValues({
  "ACTION_OPEN": NotAction.ACTION_OPEN,
  "ACTION_ACCEPT": NotAction.ACTION_ACCEPT,
  "ACTION_DECLINE": NotAction.ACTION_DECLINE
});
