import 'package:vote_app/utils/utils.dart';

enum Sex { male, female }

final sexValues = new EnumValues({
    "m": Sex.male,
    "f": Sex.female
});

class RegisterRequest {
  String email;
  String pin;
  String name;
  String birthDate;
  Sex sex;

  RegisterRequest({this.email, this.pin, this.name, this.birthDate, this.sex});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      new RegisterRequest(
          email: json["email"],
          pin: json["pin"],
          name: json["name"],
          birthDate: json["birthDate"],
          sex: sexValues.map[json["sex"]]);

  Map<String, dynamic> toJson() => {
        "email": email,
        "pin": pin,
        "name": name,
        "birthDate": birthDate,
        "sex": sexValues.reverse[sex]
      };
}
