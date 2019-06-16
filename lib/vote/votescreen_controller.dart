import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/networking/providers/vote_api_provider.dart';
import 'package:vote_app/repository/votedetail_repository.dart';
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
      print(response);
      voteScreenState.setVoteDetails(response);
    }).catchError((error) {
      voteScreenState.showError(error.toString());
    });
  }

  void verifyVote(String voteId, String optionId){
    VoteApiProvider voteApiProvider = VoteApiProvider();
    voteApiProvider.verifyVote(voteId, optionId).then((response){
      voteScreenState.valid();
    }).catchError((error){
      voteScreenState.showError(error.message);
    });
  }

  Future vote() async {
    EthereumProvider ethereumProvider = EthereumProvider(ethereumResponse: EthereumResponse(privateKey: "8d3a052b8a2525cec3b3cb65acb5bf32cd770c0295c13692ae757936467d5bd2",
    chainId: 2019,contractAddress: "0x889A9cECbe12fD3DdF80dCf8c7F9646D9e775A9e",
    abiJson: '[{"constant":true,"inputs":[],"name":"getVotes","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getCandidateNames","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getDeleteToken","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"option","type":"string"},{"name":"userid","type":"uint256"}],"name":"vote","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getCandidateIds","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getUserIds","outputs":[{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[{"name":"_id","type":"string"},{"name":"_title","type":"string"},{"name":"_options","type":"string[]"},{"name":"_user_ids","type":"uint256[]"},{"name":"_startTime","type":"uint256"},{"name":"_endTime","type":"uint256"},{"name":"_coinbase","type":"address"},{"name":"_deleteToken","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]'));
    await ethereumProvider.init();
    String token = await SharedPrefs.getAuthToken();
    var id = parseJwt(token)["id"];
    ethereumProvider.vote(id, selectedOption);
  }

}

 