class UserDetailsResponse {
  final String picture;
  final String name;

  UserDetailsResponse({this.picture, this.name});

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) =>
      new UserDetailsResponse(picture: json["picture"], name: json["name"]);

  Map<String, dynamic> toJson() => {
        "picture": picture,
        "name": name,
      };
}
