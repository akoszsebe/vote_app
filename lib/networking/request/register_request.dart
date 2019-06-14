import 'package:vote_app/utils/utils.dart';

enum Sex { MALE, FEMALE }

final sexValues = new EnumValues({
    "M": Sex.MALE,
    "F": Sex.FEMALE
});

class RegisterRequest {
  String email;
  String pin;
  String name;
  String picture;
  String birthDate;
  Sex sex;

  RegisterRequest({this.email, this.picture, this.pin, this.name, this.birthDate, this.sex});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      new RegisterRequest(
          email: json["email"],
          pin: json["pin"],
          picture: json["picture"],
          name: json["name"],
          birthDate: json["birthDate"],
          sex: sexValues.map[json["sex"]]);

  Map<String, dynamic> toJson() => {
        "email": email,
        "pin": pin,
        "name": name,
        "picture": picture,
        "birthDate": birthDate,
        "sex": sexValues.reverse[sex]
      };
}
