import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/networking/providers/register_api_provider.dart';
import 'package:vote_app/networking/request/verification_request.dart';
import 'package:vote_app/confirmation/confirmationscreen_view.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class ConfirmationScreenController extends BaseController {
  final ConfirmationScreenState confirmationScreenState;
  RegisterApiProvider _registerApiProvider = RegisterApiProvider();

  ConfirmationScreenController({this.confirmationScreenState});

  void onSubmit(String s) {
    confirmationScreenState.showLoading();
    SharedPrefs.getAuthToken().then((authToken) {
      if (authToken.isNotEmpty) {
        _registerApiProvider
            .confirm(VerificationRequest(token: s))
            .then((onValue) {
          if (onValue) {
            SharedPrefs.setLogedIn(true);
            confirmationScreenState.navigateHome();
          }
        }).catchError((error) {
          confirmationScreenState.hideLoading();
          confirmationScreenState.showError(error.message);
        });
      } else {
        confirmationScreenState.hideLoading();
        confirmationScreenState.showError("Please login again");
      }
    });
  }

  void resendCode() {
    _registerApiProvider.resend().then((onValue) {
      if (onValue) {
        confirmationScreenState.hideLoading();
      }
    }).catchError((error) {
      confirmationScreenState.hideLoading();
      confirmationScreenState.showError(error.message);
    });
  }

  @override
  void init() {}
}
