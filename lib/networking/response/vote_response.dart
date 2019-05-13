import 'package:flutter/material.dart';

class VoteResponse {
  String refreshToken;
  String authToken;

  String error;

  VoteResponse({this.refreshToken, this.authToken, this.error});

  factory VoteResponse.fromJson(Map<String, dynamic> json) => new VoteResponse(
      refreshToken: json["refreshToken"], authToken: json["authToken"]);

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
        "authToken": authToken,
      };
}

class VoteModel {
  final String title;
  final String date;
  final String content;
  final String joined;
  final Icon icon;

  VoteModel(
      this.title, this.date, this.content, this.icon, this.joined);
}
