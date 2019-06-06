import 'package:flutter/material.dart';
import 'package:vote_app/notification/notificationscreen_view.dart';
import 'package:vote_app/splash/splashscreen_view.dart';
import 'package:vote_app/register/registerscreen_view.dart';
import 'package:vote_app/confirmation/confirmationscreen_view.dart';
import 'package:vote_app/home/homescreen_view.dart';
import 'package:vote_app/vote/votescreen_view.dart';
import 'package:vote_app/votestatistics/votestatisticsscreen_view.dart';

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
