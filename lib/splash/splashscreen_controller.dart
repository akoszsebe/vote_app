import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/networking/providers/login_api_provider.dart';
import 'package:vote_app/networking/request/login_request.dart';
import 'package:vote_app/notification/firebase/firebasenotifications.dart';
import 'package:vote_app/repository/session_repository.dart';
import 'package:vote_app/splash/splashscreen_view.dart';
import 'package:vote_app/utils/jwt_decode.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class SplashScreenController extends BaseController {
  final SplashScreenState splashScreenState;
  LoginApiProvider _loginApiProvider = LoginApiProvider();

  SplashScreenController({this.splashScreenState});
  bool _logedIn = false;
  FirebaseNotifications _firebaseNotifications;
  String firebaseDeviceId = "";

  @override
  void init() {
    _firebaseNotifications = new FirebaseNotifications();
    _firebaseNotifications..setUpFirebase();

    loadData();
  }

  Future loadData() async {
    print("--------------------------------- init ----------------");
    firebaseDeviceId = await _firebaseNotifications.getToken();
    print(firebaseDeviceId);
    _logedIn = await SharedPrefs.getLogedIn();
    if (_logedIn) {
      splashScreenState.showPin();
    } else {
      splashScreenState.showLoginRegister();
    }
  }

  Future loginEmailPin(String _pin) async {
    splashScreenState.showLoader();
    if (splashScreenState.email.length != 0) {
      if (_pin.length == 6) {
        _loginApiProvider
            .login(new LoginRequest(
                email: splashScreenState.email,
                pin: _pin,
                deviceId: firebaseDeviceId))
            .then((response) {
          print(response.toString());
          var decodedToken = parseJwt(response.authToken);
          print(decodedToken.toString());
          SharedPrefs.setAuthToken(response.authToken);
          SessionRepository().setAuthToken(response.authToken);
          SessionRepository().setSalt(response.salt);
          SharedPrefs.setRefreshToken(response.refreshToken);
          if (decodedToken["active"] != true) {
            SharedPrefs.setLogedIn(true);
            SharedPrefs.setEmail(splashScreenState.email);
            splashScreenState.navigateHome();
          } else {
            splashScreenState.navigateConfirmation();
            splashScreenState.showLoginRegister();
          }
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
      loginPin(_pin);
    }
  }

  Future loginPin(String _pin) async {
    splashScreenState.showLoader();
    if (_pin.length == 6) {
      _loginApiProvider
          .loginPin(LoginPinRequest(pin: _pin, deviceId: firebaseDeviceId))
          .then((response) async {
        String authToken = await SharedPrefs.getAuthToken();
        SessionRepository().setAuthToken(authToken);
        SessionRepository().setSalt(response.salt);
        SharedPrefs.setLogedIn(true);
        splashScreenState.navigateHome();
        splashScreenState.showLoginRegister();
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

  getFirebase() {
    return _firebaseNotifications;
  }
}
