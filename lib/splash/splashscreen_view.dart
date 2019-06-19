import 'dart:async';
import 'package:vote_app/splash/splashscreen_controller.dart';
import 'package:vote_app/confirmation/confirmationscreen_view.dart';
import 'package:vote_app/utils/code_input.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/register/registerscreen_view.dart';
import 'package:vote_app/home/homescreen_view.dart';
import 'package:vote_app/utils/shared_prefs.dart';
import 'package:vote_app/utils/widgets.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  @override
  SplashScreenState createState() => SplashScreenState();
}

enum SplashType { showLoginRegister, showEmail, showLoader, showPin }

class SplashScreenState extends State<SplashScreen> {
  SplashScreenController _splashScreenController;

  SplashType isLoaded = SplashType.showLoader;

  String email = "";
  @override
  void initState() {
    super.initState();
    _splashScreenController = SplashScreenController(splashScreenState: this);
    _splashScreenController.init();
  }

  void showPin() {
    setState(() {
      isLoaded = SplashType.showPin;
    });
  }

  void showEmail() {
    setState(() {
      isLoaded = SplashType.showEmail;
    });
  }

  void showLoginRegister() {
    setState(() {
      SharedPrefs.setLogedIn(false);
      isLoaded = SplashType.showLoginRegister;
    });
  }

  void showLoader() {
    setState(() {
      isLoaded = SplashType.showLoader;
    });
  }

  void navigateHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                firebaseNotifications: _splashScreenController.getFirebase())));
  }

  void showError(String error) {
    showErrorDialog(context, error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(top: 32, left: 8),
                child: ButtonTheme(
                  minWidth: 24.0,
                  height: 48.0,
                  child: RaisedButton(
                    child: Visibility(
                      visible: checkBackArrowVisibility(),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0)),
                    color: Colors.transparent,
                    disabledColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    highlightElevation: 0,
                    elevation: 0,
                    onPressed: checkBackArrowVisibility()
                        ? () {
                            setState(() {
                              SharedPrefs.setLogedIn(false);
                              isLoaded = SplashType.showLoginRegister;
                            });
                          }
                        : null,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60.0,
                        child: Icon(
                          Icons.content_paste,
                          color: Theme.of(context).accentColor,
                          size: 60.0,
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
              Expanded(flex: 2, child: _buildLoaderOrButtons())
            ],
          )
        ],
      ),
    );
  }

  bool checkBackArrowVisibility() {
    if (isLoaded == SplashType.showLoginRegister ||
        isLoaded == SplashType.showLoader) return false;
    return true;
  }

  Widget _buildLoaderOrButtons() {
    switch (isLoaded) {
      case SplashType.showLoader:
        return buildLoader();
      case SplashType.showLoginRegister:
        return _buildNotRegistered(context);
      case SplashType.showEmail:
        return _buildIDInput(context);
      case SplashType.showPin:
        return _buildPinInput(context);
    }
    return _buildNotRegistered(context);
  }

  Widget _buildNotRegistered(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
              height: 48.0,
              width: 100.0,
              child: RoundRaisedButton(
                onPressed: () => {
                      {
                        setState(() {
                          isLoaded = SplashType.showEmail;
                        })
                      },
                    },
                context: context,
                child: new Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          Container(
              height: 48.0,
              width: 100.0,
              child: RoundInvertedRaisedButton(
                onPressed: () => {
                      {Navigator.pushNamed(context, RegisterScreen.routeName)},
                    },
                context: context,
                child: new Text(
                  "Register",
                  style: TextStyle(fontSize: 16),
                ),
              )),
        ]);
  }

  Widget _buildIDInput(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Enter email",
          style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.normal,
              fontSize: 20.0),
        ),
        Padding(
            padding: EdgeInsets.only(top: 20.0, left: 45, right: 45),
            child: new TextField(
                maxLength: 30,
                style: TextStyle(
                    color: Colors.white, fontSize: 20, letterSpacing: 1.0),
                keyboardType: TextInputType.text,
                onSubmitted: (s) {
                  email = s;
                  setState(() {
                    isLoaded = SplashType.showPin;
                  });
                },
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

  Widget _buildPinInput(BuildContext context) {
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
          length: 6,
          keyboardType: TextInputType.number,
          builder: CodeInputBuilders.lightCircle(obscureText: true),
          onFilled: (value) async {
            await Future.delayed(const Duration(milliseconds: 200));
            _splashScreenController.loginEmailPin(value);
          },
        )
      ],
    );
  }

  void navigateConfirmation() {
     Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ConfirmationScreen(
                firebaseNotifications: _splashScreenController.getFirebase())));
  }
}
