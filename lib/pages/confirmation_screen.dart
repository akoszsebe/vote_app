import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vote_app/controller/confirmation_controller.dart';
import 'package:vote_app/pages/home_screen.dart';
import 'package:vote_app/utils/widgets.dart';

class ConfirmationScreen extends StatefulWidget {
  static const routeName = '/confirmation';

  @override
  ConfirmationScreenState createState() => ConfirmationScreenState();
}

class ConfirmationScreenState extends State<ConfirmationScreen> {
  var loading = false;
  ConfirmationScreenController _confirmationScreenController;

  @override
  void initState() {
    super.initState();
    _confirmationScreenController = ConfirmationScreenController(confirmationScreenState: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.done,
                          color: Theme.of(context).accentColor,
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Confirm your account please enter the code from email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _buildInputOrLoader(context),
                              ]))
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

  Widget _buildInputOrLoader(BuildContext context) {
    if (loading) {
      return buildLoader();
    } else {
      return _buildIDInput(context);
    }
  }

  Widget _buildIDInput(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Enter verification code",
          style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.normal,
              fontSize: 20.0),
        ),
        Padding(
            padding: EdgeInsets.only(top: 24.0, left: 45, right: 45),
            child: new TextField(
                maxLength: 30,
                style: TextStyle(
                    color: Colors.white, fontSize: 24, letterSpacing: 2.0),
                keyboardType: TextInputType.text,
                onSubmitted: _confirmationScreenController.onSubmit,
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

  void showLoading() {
    setState(() {
      loading = true;
    });
  }

  void hideLoading() {
    setState(() {
      loading = false;
    });
  }

  void navigateHome() {
     Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  void showError(String s) {
     showAlertDialog(context, "Error", s);
  }
}
