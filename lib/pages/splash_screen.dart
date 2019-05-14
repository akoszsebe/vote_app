import 'dart:async';
import 'package:vote_app/networking/providers/login_api_provider.dart';
import 'package:vote_app/networking/request/login_request.dart';
import 'package:vote_app/utils/code_input.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/pages/register_screen.dart';
import 'package:vote_app/pages/home_screen.dart';
import 'package:vote_app/utils/jwt_decode.dart';
import 'package:vote_app/utils/shared_prefs.dart';
import 'package:vote_app/utils/widgets.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

enum SplashType { showLoginRegister, showEmail, showLoader, showPin }

class _SplashScreenState extends State<SplashScreen> {
  SplashType isLoaded = SplashType.showLoader;
  LoginApiProvider _loginApiProvider = LoginApiProvider();

  String _email = "";
  bool _logedIn = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() async {
        _logedIn = await SharedPrefs.getLogedIn();
        if (_logedIn) {
          setState(() {
            isLoaded = SplashType.showPin;
          });
        } else {
          setState(() {
            isLoaded = SplashType.showLoginRegister;
          });
        }
      });
    });
  }

  void loginEmailPin(String _pin) {
    setState(() {
      isLoaded = SplashType.showLoader;
    });
    if (_email.length != 0) {
      if (_pin.length == 6) {
        _loginApiProvider
            .login(new LoginRequest(email: _email, pin: _pin))
            .then((response) {
          print(response.toString());
          if (response.error == null) {
            var decodedToken = parseJwt(response.authToken);
            print(decodedToken.toString());
            SharedPrefs.setAuthToken(response.authToken);
            SharedPrefs.setRefreshToken(response.refreshToken);
            //if (decodedToken["active"] == true) {
            SharedPrefs.setLogedIn(true);
            SharedPrefs.setEmail(_email);
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            // } else {
            //   setState(() {
            //     isLoaded = SplashType.showLoginRegister;
            //   });
            //   Navigator.pushNamed(context, ConfirmationScreen.routeName);
            // }
          } else {
            SharedPrefs.setAuthToken("");
            SharedPrefs.setRefreshToken("");
            showAlertDialog(context, "Error", response.error);
            setState(() {
              isLoaded = SplashType.showEmail;
            });
          }
        });
      } else {
        setState(() {
          isLoaded = SplashType.showEmail;
        });
        showAlertDialog(context, "Wrong Pin", "Please try again");
      }
    } else {
      loginPin(_pin);
    }
  }

  Future loginPin(String _pin) async {
    setState(() {
      isLoaded = SplashType.showLoader;
    });
    if (_pin.length == 6) {
      String authToken = await SharedPrefs.getAuthToken();
      _loginApiProvider
          .loginPin(LoginPinRequest(pin: _pin), authToken)
          .then((response) {
        if (response) {
          SharedPrefs.setLogedIn(true);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          setState(() {
            isLoaded = SplashType.showLoginRegister;
          });
        } else {
          setState(() {
            isLoaded = SplashType.showLoginRegister;
            showAlertDialog(context, "Error", "login again");
          });
        }
      });
    } else {
      setState(() {
        isLoaded = SplashType.showPin;
      });
      showAlertDialog(context, "Wrong Pin", "Please try again");
    }
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
          RaisedButton(
            onPressed: () => {
                  {
                    setState(() {
                      isLoaded = SplashType.showEmail;
                    })
                  },
                },
            textColor: Theme.of(context).accentColor,
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              "Login",
            ),
          ),
          RaisedButton(
            onPressed: () => {
                  {Navigator.pushNamed(context, RegisterScreen.routeName)},
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
                  _email = s;
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
            loginEmailPin(value);
          },
        )
      ],
    );
  }
}
