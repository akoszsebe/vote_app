import 'package:flutter/material.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.blueGrey[800]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onDoubleTap: () {
                            SharedPrefs.setPin("");
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
                          "Szerusz nah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 34.0),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
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
