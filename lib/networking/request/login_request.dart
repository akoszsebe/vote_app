class LoginRequest {
  String email;
  String pin;

  LoginRequest({
    this.email,
    this.pin,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      new LoginRequest(
          email: json["email"], pin: json["pin"]);

  Map<String, dynamic> toJson() => {
        "email": email,
        "pin": pin,
    };
}

class LoginPinRequest {
  String pin;

  LoginPinRequest({
    this.pin,
  });

  factory LoginPinRequest.fromJson(Map<String, dynamic> json) =>
      new LoginPinRequest(
           pin: json["pin"]);

  Map<String, dynamic> toJson() => {
        "pin": pin,
    };
}
