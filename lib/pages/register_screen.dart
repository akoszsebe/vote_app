import 'package:flutter/material.dart';
import 'package:vote_app/pages/confirmation_screen.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String pin = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: new Form(
            child: new ListView(
              padding: new EdgeInsets.all(20.0),
              children: <Widget>[
                new Container(
                    padding: new EdgeInsets.all(20.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.card_membership,
                          color: Colors.white,
                          size: 100.0,
                        ),
                        RaisedButton(
                          onPressed: () => {
                                {},
                              },
                          textColor: Theme.of(context).accentColor,
                          color: Colors.white,
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            "Add",
                          ),
                        ),
                      ],
                    )),
                inputField('User Name', 'Enter your user name',
                    TextInputType.text, Icons.person),
                inputField('you@example.com', 'E-mail Address',
                    TextInputType.emailAddress, Icons.email),
                inputField('01-03-1995', 'Birth Date',
                    TextInputType.emailAddress, Icons.date_range),
                inputField('PIN', 'Enter a pin 4 digits',
                    TextInputType.datetime, Icons.lock, obscureText: true,
                    onFieldSubmitted: (s) {
                  pin = s;
                }, maxLength: 4),
                inputField('Confirm PIN', 'Enter your confirm pin',
                    TextInputType.number, Icons.lock,
                    obscureText: true, maxLength: 4),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      height: 48.0,
                      width: 200.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: RaisedButton(
                        onPressed: () => {
                              {
                                SharedPrefs.setPin(pin).then((response) {
                                  if (response) {
                                    Navigator.pushReplacementNamed(
                                        context, ConfirmationScreen.routeName);
                                  }
                                })
                              },
                            },
                        textColor: Theme.of(context).accentColor,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          "Register",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
  Widget inputField(
      String hint, String label, TextInputType type, IconData icon,
      {bool obscureText: false,
      Function(String) onFieldSubmitted,
      int maxLength}) {
    return Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: new TextField(
            maxLength: maxLength,
            style: TextStyle(color: Colors.white),
            keyboardType: type,
            onChanged: onFieldSubmitted,
            onSubmitted: onFieldSubmitted,
            obscureText: obscureText,
            decoration: new InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: hint,
                counterText: "",
                labelStyle: TextStyle(color: Colors.white),
                labelText: label,
                icon: new Icon(
                  icon,
                  color: Colors.white,
                ),
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)))));
  }