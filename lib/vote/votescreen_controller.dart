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
    // vote(EthereumResponse(abiJson: '[{"constant":true,"inputs":[],"name":"getVotes","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getCandidateNames","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getDeleteToken","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"option","type":"string"},{"name":"userid","type":"uint256"}],"name":"vote","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getCandidateIds","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getUserIds","outputs":[{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[{"name":"_id","type":"string"},{"name":"_title","type":"string"},{"name":"_options","type":"string[]"},{"name":"_user_ids","type":"uint256[]"},{"name":"_startTime","type":"uint256"},{"name":"_endTime","type":"uint256"},{"name":"_coinbase","type":"address"},{"name":"_deleteToken","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]',
    // chainId: 2019,chainIp: "79.115.38.91:8543",contractAddress: "0x49B490ADfd770d09634aA300B8338fAf21351Eb7",privateKey: "c8b6a546c30c3dd7844f769f45be619235fe42d9c0eb93cf766311ba6328f5f4"));
    VoteApiProvider voteApiProvider = VoteApiProvider();
    voteApiProvider.verifyVote(voteId, optionId).then((response) async {
      var saltBase64 = SessionRepository().getSalt();
      print("--------salt---------" + saltBase64);
      var ivBase64 = response.encryptedData.split(':')[0];
      print("--------iv---------" + ivBase64);
      var encodedBase64 = response.encryptedData.split(':')[1];
      print("--------encoded---------" + encodedBase64);

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
