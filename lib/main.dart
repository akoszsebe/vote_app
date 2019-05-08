import 'package:flutter/material.dart';
import 'package:vote_app/pages/splash_screen.dart';
import 'package:vote_app/pages/register_screen.dart';
import 'package:vote_app/pages/confirmation_screen.dart';
import 'package:vote_app/pages/home_screen.dart';

void main() => runApp(MyApp());

var routes = <String, WidgetBuilder>{
  RegisterScreen.routeName: (BuildContext context) => RegisterScreen(),
  ConfirmationScreen.routeName: (BuildContext context) => ConfirmationScreen(),
  HomeScreen.routeName: (BuildContext context) => HomeScreen(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.blueGrey[700],
            accentColor: Colors.purple[700]),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: routes);
  }
}
