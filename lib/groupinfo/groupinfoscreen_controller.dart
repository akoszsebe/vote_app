import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/groupinfo/groupinfoscreen_view.dart';
import 'package:vote_app/networking/providers/group_api_provider.dart';

class GroupInfoScreenController extends BaseController {
  final GroupInfoScreenState groupInfoScreenState;
  GroupApiProvider _groupApiProvider;

  GroupInfoScreenController({this.groupInfoScreenState});
 

  @override
  void init() {
    _groupApiProvider = GroupApiProvider();
  }

  void getDetails(int id){
    _groupApiProvider.getById(id).then((response){
      groupInfoScreenState.setUI(response);
    }).catchError((error){
      groupInfoScreenState.showError(error.message);
    });
    
  }

}
