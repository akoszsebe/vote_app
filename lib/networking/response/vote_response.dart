class VoteResponse {
  int id;
  String title;
  int beginning;
  String group;
  VoteType type;

  VoteResponse({this.id, this.title, this.beginning, this.group, this.type});

  factory VoteResponse.fromJson(Map<String, dynamic> json) => new VoteResponse(
      id: json["id"],
      title: json["title"],
      beginning: json["beginning"],
      group: json["group"],
      type: VoteType.fromJson(json["type"]));
}

class FinishedVoteResponse {
  int id;
  String title;
  int end;
  String group;
  VoteType type;

  FinishedVoteResponse({this.id, this.title, this.end, this.group, this.type});

  factory FinishedVoteResponse.fromJson(Map<String, dynamic> json) =>
      new FinishedVoteResponse(
          id: json["id"],
          title: json["title"],
          end: json["end"],
          group: json["group"],
          type: VoteType.fromJson(json["type"]));
}

class VoteDetailResponse {
  int id;
  String title;
  String description;
  int beginning;
  int end;
  Group group;
  VoteType type;
  List<VoteOptions> responses;

  VoteDetailResponse(
      {this.id,
      this.title,
      this.description,
      this.beginning,
      this.end,
      this.group,
      this.type,
      this.responses});

  factory VoteDetailResponse.fromJson(Map<String, dynamic> json) {
    return new VoteDetailResponse(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        beginning: json["beginning"],
        end: json["end"],
        group: Group.fromJson(json["group"]),
        type: VoteType.fromJson(json["type"]),
        responses: List<VoteOptions>.from(
            json["responses"].map((x) => VoteOptions.fromJson(x))));
  }
}

class VoteOptions {
  int id;
  String value;
  String description;

  VoteOptions({this.id, this.value, this.description});

  factory VoteOptions.fromJson(Map<String, dynamic> json) => new VoteOptions(
      id: json["id"], value: json["value"], description: json["description"]);
}

class Group {
  String name;
  int id;

  Group({this.name, this.id});

  factory Group.fromJson(Map<String, dynamic> json) =>
      new Group(name: json["name"], id: json["id"]);
}

//      DateTime.fromMillisecondsSinceEpoch(vote.beginning),
class VoteType {
  final String color;
  final String name;
  final String logo;

  VoteType({this.color, this.name, this.logo});

  factory VoteType.fromJson(Map<String, dynamic> json) => new VoteType(
      color: json["color"], name: json["name"], logo: json["logo"]);
}
