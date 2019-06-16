import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vote_app/confirmation/confirmationscreen_controller.dart';
import 'package:vote_app/home/homescreen_view.dart';
import 'package:vote_app/notification/firebase/firebasenotifications.dart';
import 'package:vote_app/utils/widgets.dart';

class ConfirmationScreen extends StatefulWidget {
  static const routeName = '/confirmation';

  final FirebaseNotifications firebaseNotifications;

  ConfirmationScreen({this.firebaseNotifications});

  @override
  ConfirmationScreenState createState() =>
      ConfirmationScreenState(firebaseNotifications: firebaseNotifications);
}

class ConfirmationScreenState extends State<ConfirmationScreen> {
  var loading = false;
  ConfirmationScreenController _confirmationScreenController;

  final FirebaseNotifications firebaseNotifications;

  ConfirmationScreenState({this.firebaseNotifications});

  @override
  void initState() {
    super.initState();
    _confirmationScreenController =
        ConfirmationScreenController(confirmationScreenState: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: new ListView(children: <Widget>[
            AppBar(
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
            Column(
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
                    "To confirm your account please enter the code from email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 48),
                ),
                _buildInputOrLoader(context),
                Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 8),
                  child: Text(
                    "Don`t got a code ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: InkWell(child:Text(
                    "resend",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 21.0),
                  ),
                  onTap: (){
                    _confirmationScreenController.resendCode();
                  },
                  ),
                ),
              ],
            )
          ]),
        ));
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomeScreen(firebaseNotifications: firebaseNotifications)));
  }

  void showError(String s) {
    showErrorDialog(context, s);
  }
}
