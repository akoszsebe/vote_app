class GroupAcceptRequest {
  int id;
  bool accepted;

  GroupAcceptRequest({
    this.id,
    this.accepted,
  });

  factory GroupAcceptRequest.fromJson(Map<String, dynamic> json) =>
      new GroupAcceptRequest(
          id: json["id"], accepted: json["accepted"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "accepted": accepted,
    };
}

