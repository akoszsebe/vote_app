import 'package:vote_app/controller/base_controller.dart';
import 'package:vote_app/pages/votestatistics_screen.dart';

class VoteStatisticsScreenController  extends BaseController{
  final VoteStatisticsScreenState voteStatisticsScreenState;

  VoteStatisticsScreenController({this.voteStatisticsScreenState});

  @override
  void init(){
    Future.delayed(const Duration(milliseconds: 500), () {
      voteStatisticsScreenState.setLoading();
    });
  }

}