import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/home/upcoming/upcomingframe_view.dart';
import 'package:vote_app/repository/votelist_repository.dart';

class UpComingFrameCrontroller extends BaseController {
  final UpcomingFrameState upcomingFrameState;
  VoteListRepository _voteListRepository;

  UpComingFrameCrontroller({this.upcomingFrameState});

  

  @override
  void init() {
    _voteListRepository = VoteListRepository();
    _voteListRepository.getUpComing().then((response) {
      upcomingFrameState.setData(response);
    }).catchError((error) {
      upcomingFrameState.showError(error.message);
    });
  }

  Future<dynamic> refresh() async {
    _voteListRepository.refreshUpComing().then((response) {
      upcomingFrameState.setData(response);
    }).catchError((error) {
      upcomingFrameState.showError(error.message);
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
