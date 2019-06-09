import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/home/finished/finishedframe_view.dart';
import 'package:vote_app/repository/votelist_repository.dart';

class FinishedFrameCrontroller extends BaseController{
  final FinishedFrameState finishedFrameState;
  VoteListRepository _voteListRepository;

  FinishedFrameCrontroller({this.finishedFrameState});


  @override
  void init() {
    _voteListRepository = VoteListRepository();
    _voteListRepository.getFinished().then((response) {
      finishedFrameState.setData(response);
    }).catchError((error) {
      finishedFrameState.showError(error.toString());
    });
  }

  Future<dynamic> refresh() async {
    _voteListRepository.refreshFinished().then((response) {
      finishedFrameState.setData(response);
    }).catchError((error) {
      finishedFrameState.showError(error.message);
    });
  }
}
