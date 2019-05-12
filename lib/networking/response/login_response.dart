class LoginResponse {
  String refreshToken;
  String authToken;

  String error;

  LoginResponse({
    this.refreshToken,
    this.authToken,
    this.error 
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      new LoginResponse(
          refreshToken: json["refreshToken"], authToken: json["authToken"]);

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
        "authToken": authToken,
    };
}
