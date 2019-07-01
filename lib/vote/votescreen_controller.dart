import 'dart:convert';

import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/networking/providers/vote_api_provider.dart';
import 'package:vote_app/repository/session_repository.dart';
import 'package:vote_app/repository/votedetail_repository.dart';
import 'package:vote_app/utils/encription.dart';
import 'package:vote_app/utils/jwt_decode.dart';
import 'package:vote_app/utils/shared_prefs.dart';
import 'package:vote_app/vote/ethereum_provider.dart';
import 'package:vote_app/vote/votescreen_view.dart';

class VoteSreenController extends BaseController {
  final VoteScreenState voteScreenState;

  VoteSreenController({this.voteScreenState});
  VoteDetailRepository _voteDetailRepository;

  String selectedOption = "";

  @override
  void init() {
    _voteDetailRepository = VoteDetailRepository();
  }

  void handleRadioValueChange(int value) {
    voteScreenState.setRadioValue(value);
    selectedOption = value.toString();
  }

  void getVotedetails(int id) {
    _voteDetailRepository.getDetails(id).then((response) {
      voteScreenState.setVoteDetails(response);
    }).catchError((error) {
      voteScreenState.showError(error.toString());
    });
  }

  Future verifyVote(String voteId, String optionId) async {
    VoteApiProvider voteApiProvider = VoteApiProvider();
    voteApiProvider.verifyVote(voteId, optionId).then((response) async {
      var saltBase64 = SessionRepository().getSalt();
      var ivBase64 = response.encryptedData.split(':')[0];
      var encodedBase64 = response.encryptedData.split(':')[1];
      var decrypted =
          AesHelper.decryptBase64(encodedBase64, saltBase64, ivBase64);
      print('decrypted=$decrypted');

      EthereumResponse ethereumResponse =
          EthereumResponse.fromJson(json.decode(decrypted));
      if (ethereumResponse != null) {
        bool voted = await vote(ethereumResponse);
        if (voted) {
          voteScreenState.valid();
        } else {
          voteScreenState.setLoading();
        }
      }
    }).catchError((error) {
      print(error.toString());
      voteScreenState.showError(error.message);
      voteScreenState.setLoading();
    });
  }

  Future<bool> vote(EthereumResponse ethereumResponse) async {
    EthereumProvider ethereumProvider =
        EthereumProvider(ethereumResponse: ethereumResponse);
    await ethereumProvider.init();
    String token = await SharedPrefs.getAuthToken();
    var id = int.parse(parseJwt(token)["id"]);
    String hash = 
        await ethereumProvider.vote(id, selectedOption).catchError((error) {
      return false;
    });
    print(hash);
    if (hash.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
