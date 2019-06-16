import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/networking/providers/user_api_provider.dart';
import 'package:vote_app/networking/response/group_response.dart';
import 'package:vote_app/home/profile/profileframe_view.dart';
import 'package:vote_app/repository/group_repository.dart';
import 'package:vote_app/utils/shared_prefs.dart';
import 'package:vote_app/utils/utils.dart';

class ProfileScreenController extends BaseController {
  final ProfileFrameState profileFrameState;
  UserApiProvider userApiProvider;
  File imageFile;

  ProfileScreenController({this.profileFrameState});

  @override
  Future init() async {
    String email = await SharedPrefs.getEmail();
    userApiProvider = UserApiProvider();
    userApiProvider.getMe().then((response) {
      profileFrameState.setUserInfo(response.name, response.picture, email);
    });
    GroupRepository groupRepository = GroupRepository();
    groupRepository.getAll().then((response) {
      profileFrameState.setGroups(response);
    }).catchError((error) {
      profileFrameState.setGroups(List<GroupResponse>());
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    //image = await FlutterExifRotation.rotateImage(path: image.path);
    imageFile = image;
    profileFrameState.setImage(Image.file(image));
  }

  void updateProfilePic() {
    if (imageFile != null) {
      userApiProvider
          .updateProfilePic(imageToBase64String(imageFile))
          .then((response) {
        profileFrameState.stopLoader();
      }).catchError((error) {
        profileFrameState.stopLoader();
        profileFrameState.showError(error.message);
      });
    } else {
      profileFrameState.stopLoader();
    }
  }
}
