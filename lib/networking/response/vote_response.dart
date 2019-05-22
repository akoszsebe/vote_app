import 'package:flutter/material.dart';

class VoteResponse {
  int id;
  String title;
  int begining;
  int group;
  String type;

  VoteResponse({this.id, this.title, this.begining, this.group, this.type});

  factory VoteResponse.fromJson(Map<String, dynamic> json) => new VoteResponse(
      id: json["id"],
      title: json["title"],
      begining: json["begining"],
      group: json["group"],
      type: json["type"]);
}

class VoteDetailResponse {
  int id;
  String title;
  String description;
  int begining;
  int end;
  int group;
  String type;
  List<String> response;

  VoteDetailResponse(
      {this.id,
      this.title,
      this.description,
      this.begining,
      this.end,
      this.group,
      this.type,
      this.response});

  factory VoteDetailResponse.fromJson(Map<String, dynamic> json) =>
      new VoteDetailResponse(
          id: json["id"],
          title: json["title"],
          description: json["description"],
          begining: json["begining"],
          end: json["end"],
          group: json["group"],
          type: json["type"],
          response: List<String>.from(json["response"]));
}

class VoteModel {
  final String title;
  final String date;
  final String content;
  final String joined;
  VoteIcon voteIcon;

  VoteModel(this.title, this.date, this.content, IconType iconType, this.joined){
    this.voteIcon = VoteIcon(iconType);
  }
}

enum IconType {
  food,
  election,
  party,
  life,
  sport,
}

class VoteIcon {
  Icon icon;
  Color color;

  VoteIcon(IconType iconType) {
    switch (iconType) {
      case IconType.food:
        this.color = Colors.green;
        this.icon = Icon(
          Icons.fastfood,
          color: this.color,
        );
        break;
      case IconType.election:
        this.color = Colors.lime;
        this.icon = Icon(
          Icons.group,
          color: this.color,
        );
        break;
      case IconType.party:
        this.color = Colors.orange;
        this.icon = Icon(
          Icons.party_mode,
          color: this.color,
        );
        break;
      case IconType.life:
        this.color = Colors.purple;
        this.icon = Icon(
          Icons.location_city,
          color: this.color,
        );

        break;
      case IconType.sport:
        this.color = Colors.pink;
        this.icon = Icon(
          Icons.directions_run,
          color: this.color,
        );
        break;
    }
  }
}
