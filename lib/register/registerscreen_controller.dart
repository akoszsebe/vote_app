import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/networking/providers/register_api_provider.dart';
import 'package:vote_app/networking/request/register_request.dart';
import 'package:vote_app/register/registerscreen_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vote_app/utils/utils.dart';

class RegisterScreenController  extends BaseController{
  final RegisterScreenState registerScreenState;

  RegisterScreenController({this.registerScreenState});

  String pin = "";
  String confirmPin = "";
  String email = "";
  String birthDate = "";
  String name = "";
  Sex groupvalue = Sex.MALE;

  RegisterApiProvider _registerApiProvider = RegisterApiProvider();


  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    registerScreenState.setImage(image);
  }

  @override
  void init() {
    super.init();
  }

  void register() {
    registerScreenState.showLoading();
    var pic = imageToBase64String(registerScreenState.image);
    var registerRequest = RegisterRequest(
        email: email, name: name, birthDate: birthDate, picture: pic, pin: pin, sex: groupvalue);
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
    registerScreenState.confirmPinValidate = false;
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
    if (confirmPin.isEmpty) {
      registerScreenState.confirmPinValidate = true;
      valid = false;
    }
    if (confirmPin != pin){
      registerScreenState.pinValidate = true;
      registerScreenState.confirmPinValidate = true;
      valid = false;
    }
    return valid;
  }
}

