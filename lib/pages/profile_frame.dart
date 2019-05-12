import 'package:flutter/material.dart';
import 'package:vote_app/pages/splash_screen.dart';
import 'package:vote_app/utils/jwt_decode.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class ProfileFrame extends StatefulWidget {
  static const routeName = '/uppcoming';

  @override
  State<StatefulWidget> createState() => _ProfileFrameState();
}

class _ProfileFrameState extends State<ProfileFrame> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  String userName = "";

  @override
  void initState() {
    SharedPrefs.getAuthToken().then((token) {
      setState(() {
        userName = parseJwt(token)["name"];
      });
    });
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
              Text(userName),
              RaisedButton(
                  onPressed: () {
                    SharedPrefs.setLogedIn(false);
                    Navigator.pushReplacementNamed(
                        context, SplashScreen.routeName);
                  },
                  textColor: Theme.of(context).accentColor,
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Logout",
                  ))
            ],
          )
        ],
      ),
    );
  }

  Future<dynamic> _refresh() async {}
}
