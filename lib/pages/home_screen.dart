import 'package:flutter/material.dart';
import 'package:vote_app/utils/shared_prefs.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  String account = "";
  String eth = "";

  var apiUrl =
      "http://192.168.0.178:8545"; //"http://10.0.2.2:8545";// //Replace with your API

  var httpClient = new Client();
  var ethClient;
  var credentials = Credentials.fromPrivateKeyHex(
      "0x0e2c31bbfc1e2d188f24bda5a0ba726b8503b5742a3098ccd8a59278c8ab42da");

  @override
  void initState() {
    ethClient = new Web3Client(apiUrl, httpClient);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: ListView(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(color: Colors.blueGrey[800])),
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(24),
                      ),
                      GestureDetector(
                          onDoubleTap: () {
                            SharedPrefs.setPin("");
                            SharedPrefs.setLogedIn(false);
                            _showDialog(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 70.0,
                            child: Icon(
                              Icons.home,
                              color: Theme.of(context).accentColor,
                              size: 70.0,
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          "Address " + account,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 34.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          "ETH " + eth,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 34.0),
                        ),
                      ),
                    ],
                  )
            ],
          ),
        ));
  }

  Future<dynamic> _refresh() {
    return ethClient.getBalance(credentials.address).then((balance) {
      print("---------");
      print(balance.getValueInUnit(EtherUnit.ether));
      print("---------");
      setState(() {
        account = credentials.address.toString();
        eth = balance.getValueInUnit(EtherUnit.ether).toString();
      });
    });
  }

  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Unregistered"),
          content: new Text("easter egg found"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
