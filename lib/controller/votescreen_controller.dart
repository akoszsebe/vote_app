import 'package:vote_app/controller/base_controller.dart';
import 'package:vote_app/pages/vote_screen.dart';

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
