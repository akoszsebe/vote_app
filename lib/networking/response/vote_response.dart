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
  final Icon icon;

  VoteModel(this.title, this.date, this.content, this.icon, this.joined);
}
