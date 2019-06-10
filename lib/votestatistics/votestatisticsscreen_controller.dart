import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/repository/votedetail_repository.dart';
import 'package:vote_app/votestatistics/votestatisticsscreen_view.dart';

class VoteStatisticsScreenController  extends BaseController{
  final VoteStatisticsScreenState voteStatisticsScreenState;

  VoteStatisticsScreenController({this.voteStatisticsScreenState});
  VoteDetailRepository _voteDetailRepository;


  @override
  void init(){
    _voteDetailRepository = VoteDetailRepository();
  }

  void getDetails(int id){
    _voteDetailRepository.getDetails(id).then((resonse){
      voteStatisticsScreenState.setDetails(resonse);
    }).catchError((error){
      voteStatisticsScreenState.showError(error.message);
    });
  }

}