class GroupResponse {
  int id;
  String name;
  String type;

  GroupResponse({
    this.id,
    this.name,
    this.type, 
  });

  factory GroupResponse.fromJson(Map<String, dynamic> json) =>
      new GroupResponse(
          id: json["id"], name: json["name"],
          type: json["message"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type" : type,
    };
}
