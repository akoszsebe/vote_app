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
    String privateKey = "a5dc2899cefa17dafea024a6feec5766eea5c7ddea944965ac4ef94497f0ed04";

    EthereumAddress myAddr =
        EthereumAddress.fromHex('0xef7d3d1cc870200355e101f6e3686ffe0cd8c0c0');

    EthereumAddress contractAddr =
        EthereumAddress.fromHex('0x939eaDA3aAFCed0502c9A26CBa59A34Ef9AD79f1');

    var httpClient = new Client();
    var client;

    
    client = new Web3Client(apiUrl, httpClient);

    
    // final ownAddress = await credentials.extractAddress();
    print("-------send--"+myAddr.toString());


    client.getBalance(myAddr).then((balance) {
      print("---------");
      print(balance.getValueInUnit(EtherUnit.ether));
      print("---------");
    });

    

    final abiCode =
        '[{"constant":true,"inputs":[],"name":"getVotes","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getCandidateNames","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getCandidateIds","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"option","type":"string"}],"name":"vote","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"_title","type":"string"},{"name":"_options","type":"string[]"},{"name":"_startTime","type":"uint256"},{"name":"_endTime","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]';
    final contract =
        DeployedContract(ContractAbi.fromJson(abiCode, 'ETH'), contractAddr);

  print("-------- Abi -");
  contract.abi.functions.toList().forEach((f)=> print(f.name));

    // final subscription = client
    //     .events(FilterOptions.events(contract: contract, event: transferEvent))
    //     .take(1)
    //     .listen((event) {
    //   final decoded = transferEvent.decodeResults(event.topics, event.data);

    //   final from = decoded[0] as EthereumAddress;
    //   final to = decoded[1] as EthereumAddress;
    //   final value = decoded[2] as BigInt;

    //   print('$from sent $value ETH to $to');
    // });

    final balance = await client.call(
        contract: contract, function: contract.function('getVotes'), params: []);
    print('We have ${balance.toString()} Eth');

    // send all our MetaCoins to the other address by calling the sendCoin
    // function
    final credentials = await client.credentialsFromPrivateKey(privateKey);
    print(credentials.toString());

    // await client.sendTransaction(
    //   credentials,
    //   Transaction.callContract(
    //     contract: contract,
    //     function: contract.function('vote'),
    //     parameters: ["2"],
    //   ),
    // );

    // await subscription.asFuture();
    // await subscription.cancel();
  }
}
