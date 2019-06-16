class LoginResponse {
  final String refreshToken;
  final String authToken;
  final String salt;

  LoginResponse({
    this.refreshToken,
    this.authToken,
    this.salt 
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      new LoginResponse(
          refreshToken: json["refreshToken"], authToken: json["authToken"],
          salt: json["salt"]);

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
        "authToken": authToken,
        "salt" : salt
    };
}

class LoginSaltResponse {
  final String salt;

  LoginSaltResponse({
    this.salt 
  });

  factory LoginSaltResponse.fromJson(Map<String, dynamic> json) =>
      new LoginSaltResponse(
          salt: json["salt"]);

  Map<String, dynamic> toJson() => {
        "salt" : salt
    };
}
