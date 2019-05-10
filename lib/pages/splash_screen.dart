import 'dart:async';
import 'package:vote_app/utils/code_input.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/pages/register_screen.dart';
import 'package:vote_app/pages/confirmation_screen.dart';
import 'package:vote_app/pages/home_screen.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

enum SplashType {
  notRegistered,
  notSameDevice,
  registered,
  notconfirmed,
  loading,
  logedIn
}

class _SplashScreenState extends State<SplashScreen> {
  SplashType isLoaded = SplashType.loading;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      SharedPrefs.getPin().then((pin) {
        setState(() {
          if (pin != "") {
            isLoaded = SplashType.registered;
          } else {
            isLoaded = SplashType.notRegistered;
          }
          switch (isLoaded) {
            case SplashType.loading:
              break;
            case SplashType.notconfirmed:
              Navigator.pushReplacementNamed(
                  context, ConfirmationScreen.routeName);
              break;
            case SplashType.notRegistered:
              break;
            case SplashType.notSameDevice:
              break;
            case SplashType.registered:
              break;
            case SplashType.logedIn:
              break;
          }
        });
      });
    });
  }

  void login(String _pin) {
    setState(() {
      isLoaded = SplashType.loading;
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      SharedPrefs.getPin().then((pin) {
        if (pin == _pin) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          setState(() {
            isLoaded = SplashType.registered;
          });
          _showDialog();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 70.0,
                        child: Icon(
                          Icons.content_paste,
                          color: Theme.of(context).accentColor,
                          size: 70.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24.0),
                      ),
                      Text(
                        "VoteApp",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 34.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(flex: 1, child: _buildLoaderOrButtons())
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLoaderOrButtons() {
    switch (isLoaded) {
      case SplashType.notconfirmed:
      case SplashType.loading:
        return _buildLoader();
      case SplashType.notRegistered:
        return _buildNotRegistered(context);
      case SplashType.notSameDevice:
      case SplashType.registered:
        return _buildIDInput(context);
      case SplashType.logedIn:
        return _buildPinVerifier(context);
    }
  }

  Widget _buildNotRegistered(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () => {
                  {
                    Navigator.pushReplacementNamed(
                        context, RegisterScreen.routeName)
                  },
                },
            textColor: Theme.of(context).accentColor,
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              "Register",
            ),
          ),
        ]);
  }

  Widget _buildLoader() {
    return Center(
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)));
  }

  Widget _buildIDInput(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Enter your CID (12)",
          style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.normal,
              fontSize: 24.0),
        ),
        Padding(
            padding: EdgeInsets.only(top: 24.0, left: 50, right: 50),
            child: new TextField(
                maxLength: 12,
                style: TextStyle(
                    color: Colors.white, fontSize: 24, letterSpacing: 5.0),
                keyboardType: TextInputType.number,
                onChanged: (s) {
                  if (s.length == 12) {
                    setState(() {
                      isLoaded = SplashType.logedIn;
                    });
                  }
                },
                onSubmitted: (s) {},
                obscureText: false,
                decoration: new InputDecoration(
                    counterText: "",
                    fillColor: Colors.white54,
                    filled: true,
                    contentPadding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 15, bottom: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(width: 0, color: Colors.white54),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(width: 0, color: Colors.white54),
                    ))))
      ],
    );
  }

  Widget _buildPinVerifier(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Enter your pin",
          style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.normal,
              fontSize: 24.0),
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.0),
        ),
        CodeInput(
          length: 4,
          keyboardType: TextInputType.number,
          builder: CodeInputBuilders.lightCircle(),
          onFilled: (value) {
            login(value);
          },
        )
      ],
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Wrong Pin"),
          content: new Text("Please try again"),
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
