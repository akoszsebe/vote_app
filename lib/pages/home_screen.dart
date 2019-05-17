import 'package:flutter/material.dart';
import 'package:vote_app/pages/finished_frame.dart';
import 'package:vote_app/pages/notification_screen.dart';
import 'package:vote_app/pages/profile_frame.dart';
import 'package:vote_app/pages/upcoming_frame.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int _notificationCount = 0;
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
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
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                actions: <Widget>[
                  FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, NotificationScreen.routeName);
                    },
                    child: notificationIcon(),
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.transparent)),
                  ),
                ],
                expandedHeight: 100.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(_childrenNames[_currentIndex],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        )),
                    background:
                        Container(color: Theme.of(context).primaryColor)),
              ),
            ];
          },
          body: _children[_currentIndex]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _notificationCount = _currentIndex * 5;
    });
  }

  Widget notificationIcon() {
    return Container(
      width: 24,
      height: 24,
      child: Stack(
        children: [
          Icon(
            Icons.notifications,
            size: 24,
          ),
          if (_notificationCount != 0)
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.bottomRight,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).accentColor,
                    border: Border.all(color: Theme.of(context).primaryColor, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Text(
                      _notificationCount > 9 ? "+9" : _notificationCount.toString(),
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
