import 'package:flutter/material.dart';
import 'package:vote_app/pages/finished_frame.dart';
import 'package:vote_app/pages/profile_frame.dart';
import 'package:vote_app/pages/upcoming_frame.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    UpcomingFrame(),
    FinishedFrame(),
    ProfileFrame()
  ];
  final List<String> _childrenNames = [
    "Upcoming Votes",
    "Finished Votes",
    "Profile"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child:Text(_childrenNames[_currentIndex],)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex:
              _currentIndex, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Upcoming'),
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
