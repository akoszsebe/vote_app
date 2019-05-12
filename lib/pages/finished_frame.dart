import 'package:flutter/material.dart';
import 'package:vote_app/utils/shared_prefs.dart';
import 'package:vote_app/utils/widgets.dart';

class FinishedFrame extends StatefulWidget {
  static const routeName = '/finished';

  @override
  State<StatefulWidget> createState() => _FinishedFrameFrameState();
}

class _FinishedFrameFrameState extends State<FinishedFrame> {
  String account = "finish";
  String eth = "mak ";
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
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
    return null;
  }
}
