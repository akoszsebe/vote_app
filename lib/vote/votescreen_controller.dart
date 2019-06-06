import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/vote/votescreen_view.dart';

class VoteSreenController extends BaseController {
  final VoteScreenState voteScreenState;

  VoteSreenController({this.voteScreenState});

  @override
  void init() {
    Future.delayed(const Duration(milliseconds: 500), () {
      voteScreenState.setLoading();
    });
  }

  void handleRadioValueChange(int value) {
    voteScreenState.setRadioValue(value);
  }
}
