import 'package:vote_app/networking/providers/register_api_provider.dart';
import 'package:vote_app/networking/request/register_request.dart';
import 'package:vote_app/pages/register_screen.dart';

class RegisterScreenController {
  final RegisterScreenState registerScreenState;

  RegisterScreenController({this.registerScreenState});

  String pin = "";
  String email = "";
  String birthDate = "";
  Sex sex = Sex.male;
  String name = "";
  RegisterApiProvider _registerApiProvider = RegisterApiProvider();

  void register() {
    registerScreenState.showLoading();
    var registerRequest = RegisterRequest(
        email: email, name: name, birthDate: birthDate, pin: pin, sex: sex);
    print(registerRequest.toJson().toString());
    if (validateForm()) {
      print("valid");
      _registerApiProvider.register(registerRequest).then((response) {
        if (response) {
          registerScreenState.navigateSplash();
        }
      }).catchError((error) {
        registerScreenState.showError("registration was failed ");
        registerScreenState.hideLoading();
      });
    } else {
      registerScreenState.hideLoading();
    }
  }

  bool validateForm() {
    bool valid = true;
    registerScreenState.nameValidate = false;
    registerScreenState.emailValidate = false;
    registerScreenState.birthDateValidate = false;
    registerScreenState.pinValidate = false;
    if (name.isEmpty) {
      registerScreenState.nameValidate = true;
      valid = false;
    }
    if (email.isEmpty) {
      registerScreenState.emailValidate = true;
      valid = false;
    }
    if (birthDate.isEmpty) {
      registerScreenState.birthDateValidate = true;
      valid = false;
    }
    if (pin.isEmpty) {
      registerScreenState.pinValidate = true;
      valid = false;
    }
    return valid;
  }
}
