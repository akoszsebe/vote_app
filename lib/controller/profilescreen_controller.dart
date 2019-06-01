import 'package:vote_app/networking/providers/group_api_provider.dart';
import 'package:vote_app/networking/response/group_response.dart';
import 'package:vote_app/pages/profile_frame.dart';
import 'package:vote_app/utils/jwt_decode.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class ProfileScreenController {
  final ProfileFrameState profileFrameState;

  ProfileScreenController({this.profileFrameState});

  void init() {
    SharedPrefs.getAuthToken().then((token) {
      profileFrameState.setName(parseJwt(token)["name"]);
    });
    SharedPrefs.getEmail().then((_email) {
      profileFrameState.setEmail(_email);
    });
    GroupApiProvider groupApiProvider = GroupApiProvider();
    groupApiProvider.getAll().then((response) {
      profileFrameState.setGroups(response);
    }).catchError((error) {
      profileFrameState.setGroups(List<GroupResponse>());
    });
  }
}
