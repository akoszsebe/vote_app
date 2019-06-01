import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vote_app/controller/registerscreen_controller.dart';
import 'package:vote_app/pages/splash_screen.dart';
import 'package:vote_app/utils/widgets.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenController _registerScreenController;

  bool pinValidate = false;
  bool emailValidate = false;
  bool birthDateValidate = false;
  bool nameValidate = false;
  var loading = false;

  var txt = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _registerScreenController =
        RegisterScreenController(registerScreenState: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: new Form(
        child: new ListView(
          padding: new EdgeInsets.all(20.0),
          children: <Widget>[
            inputField('User Name', 'Enter your name', TextInputType.text,
                Icons.person, onFieldSubmitted: (s) {
              _registerScreenController.name = s;
            }, validate: nameValidate),
            inputField('you@example.com', 'E-mail Address',
                TextInputType.emailAddress, Icons.email, onFieldSubmitted: (s) {
              _registerScreenController.email = s;
            }, validate: emailValidate),
            inputField('01-03-1995', 'Birth Date', TextInputType.text,
                Icons.date_range, onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              _showDatePicker(context);
            }, controller: txt, validate: birthDateValidate),
            inputField('PIN', 'Enter a pin 6 digits', TextInputType.datetime,
                Icons.lock,
                obscureText: true, onFieldSubmitted: (s) {
              _registerScreenController.pin = s;
            }, maxLength: 6, validate: pinValidate),
            inputField('Confirm PIN', 'Enter your confirm pin',
                TextInputType.number, Icons.lock,
                obscureText: true, maxLength: 6),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: new Container(
                      height: 48.0,
                      width: 200.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: _buildButtonOrLoader()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonOrLoader() {
    if (loading) {
      return buildLoader();
    } else {
      return RaisedButton(
        onPressed: _registerScreenController.register,
        textColor: Theme.of(context).accentColor,
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          "Register",
        ),
      );
    }
  }

  Future<Null> _showDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995, 2, 5),
      firstDate: DateTime(1960),
      lastDate: DateTime(2060),
    );
    if (picked != null) {
      setState(() {
        txt.text = DateFormat("dd-MM-yyyy").format(picked);
        _registerScreenController.birthDate =
            picked.millisecondsSinceEpoch.toString();
      });
    }
  }

  Widget inputField(
      String hint, String label, TextInputType type, IconData icon,
      {bool obscureText: false,
      Function(String) onFieldSubmitted,
      int maxLength,
      Function onTap,
      TextEditingController controller,
      bool validate = false}) {
    return Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: new TextField(
            controller: controller,
            maxLength: maxLength,
            style: TextStyle(color: Colors.white),
            keyboardType: type,
            onTap: onTap,
            onChanged: onFieldSubmitted,
            onSubmitted: onFieldSubmitted,
            obscureText: obscureText,
            decoration: new InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: hint,
                counterText: "",
                labelStyle: TextStyle(color: Colors.white),
                labelText: label,
                errorText: validate ? 'Value Can\'t Be Empty' : null,
                icon: new Icon(
                  icon,
                  color: Colors.white,
                ),
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)))));
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

  void navigateSplash() {
    Navigator.pushReplacementNamed(context, SplashScreen.routeName);
  }

  void showError(String s) {
    showAlertDialog(context, "Error", s);
  }
}
