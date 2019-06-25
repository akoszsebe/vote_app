import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/home/upcoming/upcomingframe_view.dart';
import 'package:vote_app/repository/votelist_repository.dart';

class UpComingFrameCrontroller extends BaseController {
  final UpcomingFrameState upcomingFrameState;
  VoteListRepository _voteListRepository;

  UpComingFrameCrontroller({this.upcomingFrameState});

  

  @override
  void init() {
    _voteListRepository = VoteListRepository();
    _voteListRepository.getUpComing().then((response) {
      upcomingFrameState.setData(response);
    }).catchError((error) {
      upcomingFrameState.showError(error.message);
    });
  }

  Future<dynamic> refresh() async {
    _voteListRepository.refreshUpComing().then((response) {
      upcomingFrameState.setData(response);
    }).catchError((error) {
      upcomingFrameState.showError(error.message);
    });
    return null;
  }
}
