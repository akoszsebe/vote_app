import 'package:image_picker/image_picker.dart';
import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/networking/providers/user_api_provider.dart';
import 'package:vote_app/networking/response/group_response.dart';
import 'package:vote_app/home/profile/profileframe_view.dart';
import 'package:vote_app/repository/group_repository.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class ProfileScreenController extends BaseController{
  final ProfileFrameState profileFrameState;

  ProfileScreenController({this.profileFrameState});

  @override
  void init() {
    SharedPrefs.getEmail().then((_email) {
      profileFrameState.setEmail(_email);
    });
    UserApiProvider userApiProvider = UserApiProvider();
    userApiProvider.getMe().then((response){
      profileFrameState.setName(response.name);
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
    profileFrameState.setImage(image);
  }
}
