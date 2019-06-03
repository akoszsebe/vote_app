import 'package:vote_app/controller/base_controller.dart';
import 'package:vote_app/networking/providers/login_api_provider.dart';
import 'package:vote_app/networking/request/login_request.dart';
import 'package:vote_app/pages/splash_screen.dart';
import 'package:vote_app/utils/jwt_decode.dart';
import 'package:vote_app/utils/shared_prefs.dart';
import 'package:vote_app/utils/utils.dart';

class SplashScreenController extends BaseController {
  final SplashScreenState splashScreenState;
  LoginApiProvider _loginApiProvider = LoginApiProvider();

  SplashScreenController({this.splashScreenState});
  bool _logedIn = false;

  @override
  void init() {
    loadData();
  }

  void loadData() {
    Future.delayed(const Duration(milliseconds: 300), () async {
      _logedIn = await SharedPrefs.getLogedIn();
      if (_logedIn) {
        splashScreenState.showPin();
      } else {
        splashScreenState.showLoginRegister();
      }
    });
  }

  Future loginEmailPin(String _pin) async {
    splashScreenState.showLoader();
    var deviceId = await getDeviceDetails();
    if (splashScreenState.email.length != 0) {
      if (_pin.length == 6) {
        _loginApiProvider
            .login(new LoginRequest(email: splashScreenState.email, pin: _pin,deviceId: deviceId))
            .then((response) {
          print(response.toString());
          var decodedToken = parseJwt(response.authToken);
          print(decodedToken.toString());
          SharedPrefs.setAuthToken(response.authToken);
          SharedPrefs.setRefreshToken(response.refreshToken);
          // if (decodedToken["active"] == true) {
          SharedPrefs.setLogedIn(true);
          SharedPrefs.setEmail(splashScreenState.email);
          splashScreenState.navigateHome();
          //} else {
          //   splashScreenState.navigateConfirmation();
          //   splashScreenState.showLoginRegister();
          // }
        }).catchError((error) {
          SharedPrefs.setAuthToken("");
          SharedPrefs.setRefreshToken("");
          splashScreenState.showError(error.message);
          splashScreenState.showEmail();
        });
      } else {
        splashScreenState.showEmail();
        splashScreenState.showError("Wrong Pin Please try again");
      }
    } else {
      loginPin(_pin, deviceId);
    }
  }

  Future loginPin(String _pin, String deviceId) async {
    splashScreenState.showLoader();
    if (_pin.length == 6) {
      _loginApiProvider.loginPin(LoginPinRequest(pin: _pin,deviceId: deviceId)).then((response) {
        if (response) {
          SharedPrefs.setLogedIn(true);
          splashScreenState.navigateHome();
          splashScreenState.showLoginRegister();
        }
      }).catchError((error) {
        SharedPrefs.setLogedIn(false);
        splashScreenState.showLoginRegister();
        splashScreenState.showError("login again");
      });
    } else {
      splashScreenState.showPin();
      splashScreenState.showError("Wrong Pin Please try again");
    }
  }
}
