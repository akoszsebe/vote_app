import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vote_app/networking/providers/register_api_provider.dart';
import 'package:vote_app/networking/request/register_request.dart';
import 'package:vote_app/pages/splash_screen.dart';
import 'package:vote_app/utils/widgets.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _pin = "";
  bool _pinValidate = false;
  String _email = "";
  bool _emailValidate = false;
  String _birthDate = "";
  bool _birthDateValidate = false;
  Sex _sex = Sex.male;
  String _name = "";
  bool _nameValidate = false;
  var loading = false;
  RegisterApiProvider _registerApiProvider = RegisterApiProvider();

  var txt = new TextEditingController();

  @override
  void initState() {
    super.initState();
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
              _name = s;
            }, validate: _nameValidate),
            inputField('you@example.com', 'E-mail Address',
                TextInputType.emailAddress, Icons.email, onFieldSubmitted: (s) {
              _email = s;
            }, validate: _emailValidate),
            inputField('01-03-1995', 'Birth Date', TextInputType.text,
                Icons.date_range, onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              _showDatePicker(context);
            }, controller: txt, validate: _birthDateValidate),
            inputField('PIN', 'Enter a pin 6 digits', TextInputType.datetime,
                Icons.lock,
                obscureText: true, onFieldSubmitted: (s) {
              _pin = s;
            }, maxLength: 6, validate: _pinValidate),
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
        onPressed: () {
          {
            setState(() {
              loading = true;
            });
            var registerRequest = RegisterRequest(
                email: _email,
                name: _name,
                birthDate: _birthDate,
                pin: _pin,
                sex: _sex);
            print(registerRequest.toJson().toString());
            if (validateForm()) {
              print("valid");
              _registerApiProvider.register(registerRequest).then((response) {
                if (response) {
                  Navigator.pushReplacementNamed(
                      context, SplashScreen.routeName);
                } 
              }).catchError((error){
                showAlertDialog(
                      context, "Warning", "registration was failed ");
                  setState(() {
                    loading = false;
                  });
              });
            } else {
              setState(() {
                print("nemvalid");
                loading = false;
              });
            }
          }
        },
        textColor: Theme.of(context).accentColor,
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          "Register",
        ),
      );
    }
  }

  bool validateForm() {
    bool valid = true;
    _nameValidate = false;
    _emailValidate = false;
    _birthDateValidate = false;
    _pinValidate = false;
    if (_name.isEmpty) {
      _nameValidate = true;
      valid = false;
    }
    if (_email.isEmpty) {
      _emailValidate = true;
      valid = false;
    }
    if (_birthDate.isEmpty) {
      _birthDateValidate = true;
      valid = false;
    }
    if (_pin.isEmpty) {
      _pinValidate = true;
      valid = false;
    }
    return valid;
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
        _birthDate = picked.millisecondsSinceEpoch.toString();
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
}
