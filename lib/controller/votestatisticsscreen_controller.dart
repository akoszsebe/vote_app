import 'package:vote_app/pages/votestatistics_screen.dart';

class VoteStatisticsScreenController {
  final VoteStatisticsScreenState voteStatisticsScreenState;

  VoteStatisticsScreenController({this.voteStatisticsScreenState});

  void init(){
    Future.delayed(const Duration(milliseconds: 500), () {
      voteStatisticsScreenState.setLoading();
    });
  }

}