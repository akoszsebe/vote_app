class RefreshTokenRequest {
  String refreshToken;

  RefreshTokenRequest({
    this.refreshToken,
  });

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      new RefreshTokenRequest(
           refreshToken: json["refreshToken"]);

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
    };
}