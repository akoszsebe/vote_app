class NotificationResponse {
  int id;
  String notType;
  String message;
  List<String> actions;

  NotificationResponse({
    this.id,
    this.notType,
    this.message, 
    this.actions
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      new NotificationResponse(
          id: json["id"], notType: json["not_type"],
          message: json["message"], actions: new List<String>.from(json["actions"].map((x) => x)),);

  Map<String, dynamic> toJson() => {
        "id": id,
        "not_type": notType,
        "message" : message,
        "actions" : actions
    };
}
