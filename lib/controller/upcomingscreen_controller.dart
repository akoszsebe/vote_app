import 'package:http/http.dart';
import 'package:vote_app/controller/base_controller.dart';
import 'package:vote_app/networking/providers/vote_api_provider.dart';
import 'package:vote_app/pages/upcoming_frame.dart';

class UpComingFrameCrontroller  extends BaseController{
  final UpcomingFrameState upcomingFrameState;
  VoteApiProvider _voteApiProvider;

  UpComingFrameCrontroller({this.upcomingFrameState});

    var apiUrl =
      "http://192.168.0.178:8545"; //"http://10.0.2.2:8545";// //Replace with your API

  var httpClient = new Client();
  var ethClient;

  @override
  void init(){
    _voteApiProvider = VoteApiProvider();
  }

  Future<dynamic> refresh() async {
    _voteApiProvider.getUpcoming().then((response){
      upcomingFrameState.setData(response);
    }).catchError((error){

    });
        // ethClient = new Web3Client(apiUrl, httpClient);
    // EthereumAddress _address =
    //     EthereumAddress("0x336352bb0820e31f2d657f33e909735b372f9843");
    return null;
    // ethClient.getBalance(_address).then((balance) {
    //   print("---------");
    //   print(balance.getValueInUnit(EtherUnit.ether));
    //   print("---------");
    //   setState(() {
    //     //account = _address.toString();
    //     //eth = balance.getValueInUnit(EtherUnit.ether).toString();
    //   });
    // });
    // final EthereumServerClient client =
    //     EthereumServerClient.withConnectionParameters("192.168.0.178");
    // client.printError = true;

    // client.rpcClient.request("eth_getBalance",
    //     ["0x336352bb0820e31f2d657f33e909735b372f9843"]).then((onValue) {
    //   int p = int.parse(onValue["result"].toString());
    //   print("-------------------" + p.toString());
    //   setState(() {
    //     account = "0x336352bb0820e31f2d657f33e909735b372f9843";
    //     eth = p.toString();
    //   });
    // });
  }
}
