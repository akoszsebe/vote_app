import 'package:vote_app/networking/providers/user_api_provider.dart';
import 'package:vote_app/networking/response/userdetails_response.dart';

class UserRepository {
  static final UserRepository _singleton =
      new UserRepository._internal(userApiProvider : UserApiProvider());

  final UserApiProvider userApiProvider;
  UserDetailsResponse userDetailsResponse;

  factory UserRepository() {
    return _singleton;
  }

  UserRepository._internal({this.userApiProvider});

  Future<UserDetailsResponse> getMe() async {
    if (userDetailsResponse == null) {
      UserDetailsResponse resopnse =
          await userApiProvider.getMe().catchError((error) {
        throw error;
      });
      userDetailsResponse = resopnse;
      return resopnse;
    } else
      return userDetailsResponse;
  }

  Future<bool> updateProfilePic(String base64Picture){
    userApiProvider.updateProfilePic(base64Picture).then((resonse){
      userDetailsResponse.picture = base64Picture;
      return resonse;
    }).catchError((error){
      throw error;
    });
  }
}
