import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vote_app/networking/request/register_request.dart';
import 'package:vote_app/register/registerscreen_controller.dart';
import 'package:vote_app/splash/splashscreen_view.dart';
import 'package:vote_app/utils/widgets.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenController _registerScreenController;

  bool pinValidate = false;
  bool confirmPinValidate = false;
  bool emailValidate = false;
  bool birthDateValidate = false;
  bool nameValidate = false;
  var loading = false;
  File image;

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
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 100.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                background: Container(color: Theme.of(context).primaryColor)),
          ),
        ];
      },
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: new ListView(
          padding: new EdgeInsets.all(16.0),
          children: <Widget>[
            Container(
              padding: new EdgeInsets.all(16.0),
              decoration: new BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.black38,
                        offset: new Offset(1.0, 1.0),
                        blurRadius: 5.0)
                  ]),
              child: Column(children: <Widget>[
                Center(
                  child: image == null
                      ? Text('')
                      : ClipOval(
                          child: Image.file(
                          image,
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        )),
                ),
                FloatingActionButton(
                  mini: true,
                  onPressed: _registerScreenController.getImage,
                  tooltip: 'Pick Image',
                  child: Icon(Icons.add_a_photo),
                ),
                inputField('User Name', 'Enter your name', TextInputType.text,
                    Icons.person, onFieldSubmitted: (s) {
                  _registerScreenController.name = s;
                }, validate: nameValidate),
                inputField(
                    'you@example.com',
                    'E-mail Address',
                    TextInputType.emailAddress,
                    Icons.email, onFieldSubmitted: (s) {
                  _registerScreenController.email = s;
                }, validate: emailValidate),
                inputField('01-03-1995', 'Birth Date', TextInputType.text,
                    Icons.date_range, onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  _showDatePicker(context);
                }, controller: txt, validate: birthDateValidate),
                inputField('PIN', 'Enter a pin 6 digits',
                    TextInputType.datetime, Icons.lock, obscureText: true,
                    onFieldSubmitted: (s) {
                  _registerScreenController.pin = s;
                }, maxLength: 6, validate: pinValidate),
                inputField('Confirm PIN', 'Enter your confirm pin',
                    TextInputType.number, Icons.lock, obscureText: true,
                    onFieldSubmitted: (s) {
                  _registerScreenController.confirmPin = s;
                }, maxLength: 6, validate: confirmPinValidate),
                ListTile(
                  leading: Icon(Icons.accessibility, color: Colors.white),
                  contentPadding: EdgeInsets.only(top: 16, right: 0, left: 0),
                  subtitle: Transform.translate(
                    offset: Offset(-16,0),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text("Male", style: TextStyle(color: Colors.white)),
                      Radio(
                          groupValue: _registerScreenController.groupvalue,
                          activeColor: Colors.white,
                          value: Sex.MALE,
                          onChanged: (v) {
                            setState(() {
                            _registerScreenController.groupvalue = v;
                            });
                          }),
                      Text("Female", style: TextStyle(color: Colors.white)),
                      Radio(
                        groupValue: _registerScreenController.groupvalue,
                        activeColor: Colors.white,
                        value: Sex.FEMALE,
                        onChanged: (v) {
                           setState(() {
                            _registerScreenController.groupvalue = v;
                            });
                        },
                      )
                    ],
                  )),
                  title: Align(child:Text("Gender",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                      alignment: Alignment(-1.13, 0),),
                )
              ]),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: new Container(
                      height: 48.0,
                      width: 200.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: _buildButtonOrLoader()),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildButtonOrLoader() {
    if (loading) {
      return buildLoader();
    } else {
      return RoundRaisedButton(
        onPressed: _registerScreenController.register,
        context: context,
        child: new Text(
          "Register",
          style: TextStyle(fontSize: 18),
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
                errorStyle: TextStyle(color: Colors.red[200]),
                icon: new Icon(
                  icon,
                  color: Colors.white,
                ),
                errorBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.red[200])),
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
    showErrorDialog(context, s);
  }

  void setImage(File image) {
    setState(() {
      this.image = image;
    });
  }
}
