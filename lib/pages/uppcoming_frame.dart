import 'package:flutter/material.dart';
import 'package:vote_app/utils/shared_prefs.dart';
import 'package:http/http.dart';
import 'package:vote_app/utils/widgets.dart';
import 'package:web3dart/web3dart.dart';

class UppcomingFrame extends StatefulWidget {
  static const routeName = '/uppcoming';

  @override
  State<StatefulWidget> createState() => _UppcomingFrameState();
}

class _UppcomingFrameState extends State<UppcomingFrame> {
  String account = "";
  String eth = "";
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
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView(
        children: <Widget>[
          Container(decoration: BoxDecoration(color: Colors.blueGrey[800])),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
              ),
              GestureDetector(
                  onDoubleTap: () {
                    SharedPrefs.setLogedIn(false);
                    showAlertDialog(
                        context, "Unregistered", "easter egg found");
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.home,
                      color: Theme.of(context).accentColor,
                      size: 20.0,
                    ),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      width: 200,
                      child: Text(
                        "Address " + account,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text(
                      "ETH " + eth,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Future<dynamic> _refresh() async {
    EthereumAddress _address =
        EthereumAddress("0x336352bb0820e31f2d657f33e909735b372f9843");
    return ethClient.getBalance(_address).then((balance) {
      print("---------");
      print(balance.getValueInUnit(EtherUnit.ether));
      print("---------");
      setState(() {
        account = _address.toString();
        eth = balance.getValueInUnit(EtherUnit.ether).toString();
      });
    });
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
