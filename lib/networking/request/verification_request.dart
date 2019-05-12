class VerificationRequest {
  String token;

  VerificationRequest({
    this.token,
  });

  factory VerificationRequest.fromJson(Map<String, dynamic> json) =>
      new VerificationRequest(
          token: json["token"]);

  Map<String, dynamic> toJson() => {
        "token": token,
    };
}
