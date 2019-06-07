import 'package:flutter/material.dart';
import 'package:vote_app/utils/utils.dart';

class VoteResponse {
  int id;
  String title;
  int beginning;
  String group;
  IconType type;

  VoteResponse({this.id, this.title, this.beginning, this.group, this.type});

  factory VoteResponse.fromJson(Map<String, dynamic> json) => new VoteResponse(
      id: json["id"],
      title: json["title"],
      beginning: json["beginning"],
      group: json["group"],
      type: iconTypeValues.map[json["type"]]);
}

class FinishedVoteResponse {
  int id;
  String title;
  int end;
  String group;
  IconType type;

  FinishedVoteResponse({this.id, this.title, this.end, this.group, this.type});

  factory FinishedVoteResponse.fromJson(Map<String, dynamic> json) =>
      new FinishedVoteResponse(
          id: json["id"],
          title: json["title"],
          end: json["end"],
          group: json["group"],
          type: iconTypeValues.map[json["type"]]);
}

class VoteDetailResponse {
  int id;
  String title;
  String description;
  int beginning;
  int end;
  Group group;
  String type;
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
        type: json["type"],
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

  Group({this.name});
  factory Group.fromJson(Map<String, dynamic> json) =>
      new Group(name: json["name"]);
}

class VoteModel {
  final int id;
  final String title;
  final DateTime date;
  final String content;
  final String rightText;
  VoteIcon voteIcon;

  factory VoteModel.fromVoteResponse(VoteResponse vote) => new VoteModel(
      vote.id,
      vote.title,
      DateTime.fromMillisecondsSinceEpoch(vote.beginning),
      vote.group,
      vote.type,
      vote.id.toString());

  factory VoteModel.fromFinishedVoteResponse(FinishedVoteResponse vote) =>
      new VoteModel(
          vote.id,
          vote.title,
          DateTime.fromMillisecondsSinceEpoch(vote.end),
          vote.group,
          vote.type,
          vote.id.toString());

  VoteModel(this.id, this.title, this.date, this.content, IconType iconType,
      this.rightText) {
    this.voteIcon = VoteIcon(iconType);
  }
}

enum IconType { FOOD, ELECTION, PARTY, LIFE, SPORT, GROUP }

final iconTypeValues = new EnumValues({
  "FOOD": IconType.FOOD,
  "ELECTION": IconType.ELECTION,
  "PARTY": IconType.PARTY,
  "LIFE": IconType.LIFE,
  "SPORT": IconType.SPORT,
  "GROUP": IconType.GROUP,
});

class VoteIcon {
  Icon icon;
  Color color;

  VoteIcon(IconType iconType) {
    switch (iconType) {
      case IconType.FOOD:
        this.color = Colors.green;
        this.icon = Icon(
          Icons.fastfood,
          color: this.color,
        );
        break;
      case IconType.ELECTION:
        this.color = Colors.lime;
        this.icon = Icon(
          Icons.group,
          color: this.color,
        );
        break;
      case IconType.PARTY:
        this.color = Colors.orange;
        this.icon = Icon(
          Icons.party_mode,
          color: this.color,
        );
        break;
      case IconType.LIFE:
        this.color = Colors.purple;
        this.icon = Icon(
          Icons.location_city,
          color: this.color,
        );

        break;
      case IconType.SPORT:
        this.color = Colors.pink;
        this.icon = Icon(
          Icons.directions_run,
          color: this.color,
        );
        break;
      case IconType.GROUP:
        this.color = Colors.brown;
        this.icon = Icon(
          Icons.people,
          color: this.color,
        );
        break;
    }
  }
}
