import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class EthereumProvider {
  // var _apiUrl = "http://192.168.0.150:8543";

  var _httpClient = new Client();
  var _client;
  final EthereumResponse ethereumResponse;
  EthereumAddress _contractAddr;
  Credentials _credentials;
  EthereumAddress _ownAddress;
  DeployedContract _contract;

  EthereumProvider({this.ethereumResponse}) {
    _client = new Web3Client(ethereumResponse.chainIp, _httpClient);
  }

  Future init() async {
    _contractAddr = EthereumAddress.fromHex(ethereumResponse.contractAddress);
    _credentials =
        await _client.credentialsFromPrivateKey(ethereumResponse.privateKey);
    _ownAddress = await _credentials.extractAddress();
    _contract = DeployedContract(
        ContractAbi.fromJson(ethereumResponse.abiJson, 'Voter'), _contractAddr);
    print("-------- Abi -");
    _contract.abi.functions.toList().forEach((f) => print(f.name));
  }

  Future vote(int userId, String option) async {
    final trans = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        from: _ownAddress,
        contract: _contract,
        function: _contract.function('vote'),
        parameters: [option, BigInt.from(userId)],
      ),
      chainId: ethereumResponse.chainId,
    );
    print('${trans.toString()} ');
  }

  getBalance() {
    print("-------send--" + _ownAddress.toString());
    _client.getBalance(_ownAddress).then((balance) {
      print("---------");
      print(balance.getValueInUnit(EtherUnit.ether));
      print("---------");
    });
  }

  getVotes() async {
    final balance = await _client.call(
        contract: _contract,
        function: _contract.function('getVotes'),
        params: []);
    print('We have ${balance.toString()} ');
  }
}

class EthereumResponse {
  final String privateKey;
  final String contractAddress;
  final int chainId;
  final String abiJson;
  final String chainIp;

  EthereumResponse(
      {this.privateKey, this.contractAddress, this.chainId, this.abiJson,this.chainIp});

  factory EthereumResponse.fromJson(Map<String, dynamic> json) =>
      new EthereumResponse(
          privateKey: json["privateKey"],
          abiJson: json["abi"],
          chainId: json["chainId"],
          chainIp: json["chainIp"],
          contractAddress: json["contractAddress"]);
}
