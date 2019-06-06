import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/votestatistics/votestatisticsscreen_view.dart';

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