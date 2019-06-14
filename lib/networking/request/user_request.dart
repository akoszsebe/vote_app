class ProfilPicUpdateRequest{
  final String picture;

  ProfilPicUpdateRequest({
    this.picture,
  });

  factory ProfilPicUpdateRequest.fromJson(Map<String, dynamic> json) =>
      new ProfilPicUpdateRequest(
          picture: json["picture"]);

  Map<String, dynamic> toJson() => {
        "picture": picture,
    };
} 