import 'package:vote_app/networking/providers/vote_api_provider.dart';
import 'package:vote_app/networking/response/vote_response.dart';

class VoteListRepository {
  static final VoteListRepository _singleton =
      new VoteListRepository._internal(voteApiProvider: VoteApiProvider());

  final List<VoteResponse> _cachedUpComingVotes = List<VoteResponse>();
  final List<FinishedVoteResponse> _cachedFinishedVotes = List<FinishedVoteResponse>();
  final VoteApiProvider voteApiProvider;

  factory VoteListRepository() {
    return _singleton;
  }

  VoteListRepository._internal({this.voteApiProvider});

  Future<List<VoteResponse>> getUpComing() async {
    if (_cachedUpComingVotes.isEmpty) {
      List<VoteResponse> resopnse =
          await voteApiProvider.getUpcoming().catchError((error) {
        throw error;
      });
      _cachedUpComingVotes.clear();
      _cachedUpComingVotes.addAll(resopnse);
      return resopnse;
    } else
      return _cachedUpComingVotes;
  }

  Future<List<VoteResponse>> refreshUpComing() async {
    List<VoteResponse> resopnse =
        await voteApiProvider.getUpcoming().catchError((error) {
      throw error;
    });
    _cachedUpComingVotes.clear();
    _cachedUpComingVotes.addAll(resopnse);
    return resopnse;
  }

  Future<List<FinishedVoteResponse>> getFinished() async {
    if (_cachedFinishedVotes.isEmpty) {
      List<FinishedVoteResponse> resopnse =
          await voteApiProvider.getFinished().catchError((error) {
        throw error;
      });
      _cachedFinishedVotes.clear();
      _cachedFinishedVotes.addAll(resopnse);
      return resopnse;
    } else
      return _cachedFinishedVotes;
  }

  Future<List<FinishedVoteResponse>> refreshFinished() async {
    List<FinishedVoteResponse> resopnse =
        await voteApiProvider.getFinished().catchError((error) {
      throw error;
    });
    _cachedFinishedVotes.clear();
    _cachedFinishedVotes.addAll(resopnse);
    return resopnse;
  }
}
