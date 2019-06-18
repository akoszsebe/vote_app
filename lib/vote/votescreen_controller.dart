import 'dart:convert';

import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/networking/providers/vote_api_provider.dart';
import 'package:vote_app/repository/session_repository.dart';
import 'package:vote_app/repository/votedetail_repository.dart';
import 'package:encrypt/encrypt.dart';
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
      print(response);
      voteScreenState.setVoteDetails(response);
    }).catchError((error) {
      voteScreenState.showError(error.toString());
    });
  }

  Future verifyVote(String voteId, String optionId) async {
    // VoteApiProvider voteApiProvider = VoteApiProvider();
    // voteApiProvider.verifyVote(voteId, optionId).then((response) {
    //   voteScreenState.valid();

    // var password = SessionRepository().getSalt();
    // print("--------salt---------" + password);

    //final plainText = "{abi: 'this is a fake abi',\nchainId: 'this is a fake chain id',\ncontractAddress: 'this is a fake contract address',\nprivateKey: 'this is a fake private key',}";
    // final key = Key.fromUtf8("7D6F855E85E514398136A5E8B9C97D67");
    // final iv = IV.fromLength(16);

    // final encrypter = Encrypter(AES(key,mode: AESMode.ctr,padding: null));

    // final encrypted = Encrypted.fromBase16("d365b2483e8b24f986aa848e373fb7e9cc78a084e6");//encrypter.encrypt(plainText, iv: iv);
    // final decrypted = encrypter.decrypt(encrypted, iv: iv);

    // print("result : "+decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    // R4PxiU3h8YoIRqVowBXm

    // }).catchError((error) {
    //   print(error.toString());
    //   voteScreenState.showError(error.message);
    // });

    var saltbase64 = "4QdIba2QA2iV3+857rN6RL3YPaay7UuH";

    //var message = 'Hello world!';
    var token = saltbase64;
    var cipherIV = '81kTkXrSEoD3JbeT';
   // var result = AesHelper.encrypt(message, token, cipherIV);

   // print('result=$result');

    var encoded = "6/VaZs8ISly6rczcgnbr4nnPA6PjvdtxdzyIlneHNnBd5ObFxBrqE1KUsvC/icOcjJHn/u2KlcC58oJ4VD2f4ZunlNQBlOdd+Tg20H+b35CbFij2B7cwjLKUQq4tWPDjrKLNOVsP681ZsQu0EIqQBFUPueHSTHHz9nsmRe+67fBnL51AYk60mDeAndZEF1VwmSHnjYMxI6Ya7GpaWqk=";

    var dec = AesHelper.decryptBase64(encoded, token, cipherIV);
    print('dec=$dec');
  }

  Future vote() async {
    EthereumProvider ethereumProvider = EthereumProvider(
        ethereumResponse: EthereumResponse(
            privateKey:
                "8d3a052b8a2525cec3b3cb65acb5bf32cd770c0295c13692ae757936467d5bd2",
            chainId: 2019,
            contractAddress: "0x889A9cECbe12fD3DdF80dCf8c7F9646D9e775A9e",
            abiJson:
                '[{"constant":true,"inputs":[],"name":"getVotes","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getCandidateNames","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getDeleteToken","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"option","type":"string"},{"name":"userid","type":"uint256"}],"name":"vote","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getCandidateIds","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getUserIds","outputs":[{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[{"name":"_id","type":"string"},{"name":"_title","type":"string"},{"name":"_options","type":"string[]"},{"name":"_user_ids","type":"uint256[]"},{"name":"_startTime","type":"uint256"},{"name":"_endTime","type":"uint256"},{"name":"_coinbase","type":"address"},{"name":"_deleteToken","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]'));
    await ethereumProvider.init();
    String token = await SharedPrefs.getAuthToken();
    var id = parseJwt(token)["id"];
    ethereumProvider.vote(id, selectedOption);
  }
}
