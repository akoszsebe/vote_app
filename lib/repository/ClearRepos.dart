import 'package:vote_app/repository/group_repository.dart';
import 'package:vote_app/repository/session_repository.dart';
import 'package:vote_app/repository/user_repository.dart';
import 'package:vote_app/repository/votedetail_repository.dart';
import 'package:vote_app/repository/votelist_repository.dart';

class ClearRepos{

  static void clearAll(){
    GroupRepository().clear();
    SessionRepository().clear();
    UserRepository().clear();
    VoteDetailRepository().clear();
    VoteListRepository().clear();
  }
}