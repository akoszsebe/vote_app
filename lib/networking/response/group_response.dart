import 'package:vote_app/networking/response/vote_response.dart';

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

class GroupDetailResponse {
  int id;
  String name;
  String description;
  GroupType type;
  GroupVotings voting;

  GroupDetailResponse({
    this.id,
    this.name,
    this.description, 
    this.type,
    this.voting
  });

  factory GroupDetailResponse.fromJson(Map<String, dynamic> json) =>
      new GroupDetailResponse(
          id: json["id"], name: json["name"],
          description: json["description"],
          type: GroupType.fromJson(json["type"]),
          voting: GroupVotings.fromJson(json["voting"])
          );

}

class GroupType {
  final String color;
  final String name;
  final String logo;

  GroupType({this.color, this.name, this.logo});

  factory GroupType.fromJson(Map<String, dynamic> json) => new GroupType(
      color: json["color"], name: json["name"], logo: json["logo"]);
}

class GroupVotings{
  final List<VoteResponse> upcoming;
  final List<FinishedVoteResponse> finished;

  GroupVotings({this.upcoming, this.finished});

  factory GroupVotings.fromJson(Map<String, dynamic> json) => new GroupVotings(
    upcoming: List<VoteResponse>.from(json["upcoming"].map((x) => VoteResponse.fromJsonNullable(x))),
    finished:  List<FinishedVoteResponse>.from(json["finished"].map((x) => FinishedVoteResponse.fromJsonNullable(x)))
  );
}