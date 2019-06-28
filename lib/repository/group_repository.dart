import 'package:vote_app/networking/providers/group_api_provider.dart';
import 'package:vote_app/networking/response/group_response.dart';

class GroupRepository {
  static final GroupRepository _singleton =
      new GroupRepository._internal(groupApiProvider: GroupApiProvider());

  final List<GroupResponse> _cachedGroupes = List<GroupResponse>();
  
  final GroupApiProvider groupApiProvider;

  factory GroupRepository() {
    return _singleton;
  }

  GroupRepository._internal({this.groupApiProvider});

  Future<List<GroupResponse>> getAll() async {
    if (_cachedGroupes.isEmpty) {
      List<GroupResponse> resopnse =
          await groupApiProvider.getAll().catchError((error) {
        throw error;
      });
      _cachedGroupes.clear();
      _cachedGroupes.addAll(resopnse);
      return resopnse;
    } else
      return _cachedGroupes;
  }

  void clear(){
    _cachedGroupes.clear();
  }

}
