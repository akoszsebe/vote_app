import 'package:flutter/material.dart';
import 'package:vote_app/pages/notification_screen.dart';
import 'package:vote_app/pages/splash_screen.dart';
import 'package:vote_app/pages/register_screen.dart';
import 'package:vote_app/pages/confirmation_screen.dart';
import 'package:vote_app/pages/home_screen.dart';
import 'package:vote_app/pages/vote_screen.dart';
import 'package:vote_app/pages/votestatistics_screen.dart';

void main() => runApp(MyApp());

var routes = <String, WidgetBuilder>{
  RegisterScreen.routeName: (BuildContext context) => RegisterScreen(),
  ConfirmationScreen.routeName: (BuildContext context) => ConfirmationScreen(),
  HomeScreen.routeName: (BuildContext context) => HomeScreen(),
  SplashScreen.routeName: (BuildContext context) => SplashScreen(),
  VoteScreen.routeName: (BuildContext context) => VoteScreen(),
  VoteStatisticsScreen.routeName: (BuildContext context) =>
      VoteStatisticsScreen(),
  NotificationScreen.routeName: (BuildContext context) => NotificationScreen(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vote App',
        theme: ThemeData(
            primaryColor: Colors.blueGrey[800],
            primaryColorLight: Colors.blueGrey[600],
            accentColor: Colors.cyan[600],
            scaffoldBackgroundColor: Colors.blueGrey[800],
            unselectedWidgetColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: routes);
  }
}
