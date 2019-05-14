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
  String userName = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    SharedPrefs.getAuthToken().then((token) {
      setState(() {
        userName = parseJwt(token)["name"];
      });
    });
    SharedPrefs.getEmail().then((_email) {
      setState(() {
        email = _email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            alignment: Alignment.centerLeft,
            margin: new EdgeInsets.all(16.0),
            padding: new EdgeInsets.all(16.0),
            decoration: new BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                boxShadow: [
                  new BoxShadow(
                      color: Colors.black38,
                      offset: new Offset(1.0, 1.0),
                      blurRadius: 5.0)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: new EdgeInsets.only(left: 16.0, top: 8.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40.0,
                          child: Icon(
                            Icons.person_outline,
                            color: Theme.of(context).accentColor,
                            size: 60.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                        ),
                        new Text(
                          userName,
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                        ),
                        new Text(
                          email,
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white70),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                        ),
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
                    ),
                  ),
                ),
              ],
            )),
        Container(
            alignment: Alignment.centerLeft,
            margin: new EdgeInsets.all(16.0),
            padding: new EdgeInsets.all(8.0),
            decoration: new BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                boxShadow: [
                  new BoxShadow(
                      color: Colors.black38,
                      offset: new Offset(1.0, 1.0),
                      blurRadius: 5.0)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(top: 8.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "About",
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      SizedBox(
                        height: 5,
                        width: 30,
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _createPersonInfo(
                              "Jozsa Tibold", "Web", "assets/tibold.jpg"),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                          ),
                          _createPersonInfo(
                              "Solyom Ferenc", "Blockchain", "assets/feco.jpg"),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                          ),
                          _createPersonInfo(
                              "Zsebe Akos", "Mobile", "assets/akos.jpg")
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Widget _createPersonInfo(String name, String role, String pic) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: ExactAssetImage(pic),
          radius: 30.0,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
        ),
        new Text(
          name,
          style: new TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6),
        ),
        new Text(
          role,
          style: new TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.white70),
        ),
      ],
    );
  }
}
