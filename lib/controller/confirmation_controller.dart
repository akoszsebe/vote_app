import 'package:vote_app/controller/base_controller.dart';
import 'package:vote_app/networking/providers/register_api_provider.dart';
import 'package:vote_app/networking/request/verification_request.dart';
import 'package:vote_app/pages/confirmation_screen.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class ConfirmationScreenController extends BaseController{
  final ConfirmationScreenState confirmationScreenState;
  RegisterApiProvider _registerApiProvider = RegisterApiProvider();

  ConfirmationScreenController({this.confirmationScreenState});

  void onSubmit(String s) {
    confirmationScreenState.showLoading();
    SharedPrefs.getAuthToken().then((authToken) {
      if (authToken.isNotEmpty) {
        _registerApiProvider
            .confirm(VerificationRequest(token: s), authToken)
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

  @override
  void init() {
  }

}
