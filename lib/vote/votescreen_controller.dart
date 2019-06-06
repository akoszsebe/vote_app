import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/repository/votedetail_repository.dart';
import 'package:vote_app/vote/votescreen_view.dart';

class VoteSreenController extends BaseController {
  final VoteScreenState voteScreenState;

  VoteSreenController({this.voteScreenState});
  VoteDetailRepository _voteDetailRepository;

  @override
  void init() {
    _voteDetailRepository = VoteDetailRepository();
  }

  void handleRadioValueChange(int value) {
    voteScreenState.setRadioValue(value);
  }

  void getVotedetails(int id) {
    _voteDetailRepository.getDetails(id).then((response) {
      print(response);
      voteScreenState.setVoteDetails(response);
    }).catchError((error) {
      voteScreenState.showError(error.toString());
    });
  }
}
