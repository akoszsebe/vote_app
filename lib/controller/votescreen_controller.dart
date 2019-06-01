import 'package:vote_app/pages/vote_screen.dart';

class VoteSreenController {
  final VoteScreenState voteScreenState;

  VoteSreenController({this.voteScreenState});

  void init(){
    Future.delayed(const Duration(milliseconds: 500), () {
      voteScreenState.setLoading();
    });
  }


  void handleRadioValueChange(int value) {
    voteScreenState.setRadioValue(value);
  }


}