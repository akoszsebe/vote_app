import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:vote_app/utils/utils.dart';
import 'package:vote_app/utils/widgets.dart';
import 'package:web3dart/web3dart.dart';

class UpcomingFrame extends StatefulWidget {
  static const routeName = '/uppcoming';

  @override
  State<StatefulWidget> createState() => _UpcomingFrameState();
}

class _UpcomingFrameState extends State<UpcomingFrame> {
  final List<VoteModel> data = [
    VoteModel('Food for friday lunch', "2019-05-15", "Accenture",
        IconType.food, "vote"),
    VoteModel('Food for friday morning', "2019-05-16", "Accenture",
        IconType.food, "vote in\n 1 day"),
    VoteModel('Boss', "2019-05-18", "Romania",
        IconType.election, "vote in\n 1 day"),
    VoteModel('What to sport together', "2019-05-18", "Friends",
        IconType.sport, "vote in\n 2 days")
  ];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var apiUrl =
      "http://192.168.0.178:8545"; //"http://10.0.2.2:8545";// //Replace with your API

  var httpClient = new Client();
  var ethClient;

  @override
  void initState() {
    super.initState();
    ethClient = new Web3Client(apiUrl, httpClient);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return DarkRefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView.builder(
        itemBuilder: (context, index) =>
            buildListItem(context, index, data, false),
        itemCount: data.length,
      ),
    );
  }

  Future<dynamic> _refresh() async {
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
