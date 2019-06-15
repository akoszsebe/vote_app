import 'package:http/http.dart';
import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/repository/votedetail_repository.dart';
import 'package:vote_app/vote/votescreen_view.dart';
import 'package:web3dart/web3dart.dart';

class VoteSreenController extends BaseController {
  final VoteScreenState voteScreenState;

  VoteSreenController({this.voteScreenState});
  VoteDetailRepository _voteDetailRepository;

  @override
  void init() {
    _voteDetailRepository = VoteDetailRepository();
  }

  void handleRadioValueChange(int value) {
    voteScreenState.setRadioValue(value);
  }

  void getVotedetails(int id) {
    _voteDetailRepository.getDetails(id).then((response) {
      print(response);
      voteScreenState.setVoteDetails(response);
    }).catchError((error) {
      voteScreenState.showError(error.toString());
    });
  }

  var apiUrl = "http://192.168.0.150:8543";

  Future connectToChain() async {
    //"http://10.0.2.2:8545";// //Replace with your API
    String privateKey =
        "8d3a052b8a2525cec3b3cb65acb5bf32cd770c0295c13692ae757936467d5bd2";

    EthereumAddress contractAddr =
        EthereumAddress.fromHex('0x889A9cECbe12fD3DdF80dCf8c7F9646D9e775A9e');

    var httpClient = new Client();
    var client;

    client = new Web3Client(apiUrl, httpClient);

// send all our MetaCoins to the other address by calling the sendCoin
    // function
    Credentials credentials =
        await client.credentialsFromPrivateKey(privateKey);

    final ownAddress = await credentials.extractAddress();
    // final ownAddress = await credentials.extractAddress();
    print("-------send--" + ownAddress.toString());

    client.getBalance(ownAddress).then((balance) {
      print("---------");
      print(balance.getValueInUnit(EtherUnit.ether));
      print("---------");
    });

    final abiCode =
        '[{"constant":true,"inputs":[],"name":"getVotes","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getCandidateNames","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getDeleteToken","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"option","type":"string"},{"name":"userid","type":"uint256"}],"name":"vote","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getCandidateIds","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getUserIds","outputs":[{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[{"name":"_id","type":"string"},{"name":"_title","type":"string"},{"name":"_options","type":"string[]"},{"name":"_user_ids","type":"uint256[]"},{"name":"_startTime","type":"uint256"},{"name":"_endTime","type":"uint256"},{"name":"_coinbase","type":"address"},{"name":"_deleteToken","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]';
    final contract =
        DeployedContract(ContractAbi.fromJson(abiCode, 'Voter'), contractAddr);

    print("-------- Abi -");
    contract.abi.functions.toList().forEach((f) => print(f.name));

    

    final trans = await client.sendTransaction(
      credentials,
      Transaction.callContract(
        from: ownAddress,
        contract: contract,
        function: contract.function('vote'),
        parameters: ["1",BigInt.from(10)],
      ),
      chainId : 2019,
    );
    print('We have ${trans.toString()} ');

    final balance = await client.call(
        contract: contract,
        function: contract.function('getVotes'),
        params: []);
    print('We have ${balance.toString()} ');

    await client.dispose();
  }
}

 