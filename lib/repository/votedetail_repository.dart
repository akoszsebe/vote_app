import 'package:vote_app/base/basecachemanager.dart';
import 'package:vote_app/networking/providers/vote_api_provider.dart';
import 'package:vote_app/networking/response/vote_response.dart';

class VoteDetailRepository {
  static final VoteDetailRepository _singleton =
      new VoteDetailRepository._internal(
          cache: Cache<VoteDetailResponse>(),
          voteApiProvider: VoteApiProvider());

  final Cache<VoteDetailResponse> cache;
  final VoteApiProvider voteApiProvider;

  factory VoteDetailRepository() {
    return _singleton;
  }

  VoteDetailRepository._internal({this.cache, this.voteApiProvider});

  Future<VoteDetailResponse> getDetails(int id) async {
    if (cache.get(id) == null) {
      VoteDetailResponse resopnse =
          await voteApiProvider.getDetails(id).catchError((error) {
        throw error;
      });
      cache.put(resopnse.id, resopnse);
      return resopnse;
    } else
      return cache.get(id);
  }

   void clear() {
    cache.cache.clear();
  }
}
