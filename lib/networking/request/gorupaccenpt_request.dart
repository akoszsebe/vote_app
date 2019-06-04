class GroupAcceptRequest {
  bool accepted;

  GroupAcceptRequest({
    this.accepted,
  });

  factory GroupAcceptRequest.fromJson(Map<String, dynamic> json) =>
      new GroupAcceptRequest(accepted: json["accepted"]);

  Map<String, dynamic> toJson() => {
        "accepted": accepted,
    };
}

