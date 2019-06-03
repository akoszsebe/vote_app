class LoginRequest {
  String email;
  String pin;
  String deviceId;

  LoginRequest({this.email, this.pin, this.deviceId});

  factory LoginRequest.fromJson(Map<String, dynamic> json) => new LoginRequest(
      email: json["email"], pin: json["pin"], deviceId: json["deviceId"]);

  Map<String, dynamic> toJson() =>
      {"email": email, "pin": pin, "deviceId": deviceId};
}

class LoginPinRequest {
  String pin;
  String deviceId;

  LoginPinRequest({this.pin, this.deviceId});

  factory LoginPinRequest.fromJson(Map<String, dynamic> json) =>
      new LoginPinRequest(pin: json["pin"], deviceId: json["deviceId"]);

  Map<String, dynamic> toJson() => {"pin": pin, "deviceId": deviceId};
}
