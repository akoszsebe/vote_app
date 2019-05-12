import 'package:flutter/material.dart';
import 'package:vote_app/pages/confirmation_screen.dart';
import 'package:vote_app/pages/profile_frame.dart';
import 'package:vote_app/pages/uppcoming_frame.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
   UppcomingFrame(),
   ConfirmationScreen(),
   ProfileFrame()
 ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex:
              _currentIndex, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Uppcoming'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.done_all),
              title: new Text('Finished'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile'))
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: _children[_currentIndex]);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
