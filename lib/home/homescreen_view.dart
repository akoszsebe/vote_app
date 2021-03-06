import 'package:flutter/material.dart';
import 'package:vote_app/home/homescreen_controller.dart';
import 'package:vote_app/networking/response/notification_response.dart';
import 'package:vote_app/home/finished/finishedframe_view.dart';
import 'package:vote_app/notification/firebase/firebasenotifications.dart';
import 'package:vote_app/notification/notificationscreen_view.dart';
import 'package:vote_app/home/profile/profileframe_view.dart';
import 'package:vote_app/home/upcoming/upcomingframe_view.dart';
import 'package:vote_app/utils/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  final FirebaseNotifications firebaseNotifications;

  HomeScreen({this.firebaseNotifications});

  @override
  State<StatefulWidget> createState() =>
      HomeScreenState(firebaseNotifications: firebaseNotifications);
}

class HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final FirebaseNotifications firebaseNotifications;
  int _currentIndex = 0;
  int _notificationCount = 0;
  bool isFilterVisible = true;

  HomeScreenState({this.firebaseNotifications});

  HomeSreenController _homeSreenController;

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
    _homeSreenController = HomeSreenController(homeScreenState: this);
    _homeSreenController.init();
    firebaseNotifications.addListener(() {
      _homeSreenController.fillNotifications();
    });
  }

  void setNotifications(List<NotificationResponse> notifications) {
    setState(() {
      this._notificationCount = notifications.length;
    });
  }

  void resetCurentIndex() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _homeSreenController.fillNotifications();
    }
  }

  int getCurrentIndex() {
    return _currentIndex;
  }

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 2) {
        isFilterVisible = false;
      } else if (!isFilterVisible) {
        isFilterVisible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _homeSreenController.onWillPop,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: _homeSreenController.onTabTapped,
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
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    actions: <Widget>[
                      Visibility(
                        visible: isFilterVisible,
                        child: MaterialButton(
                          minWidth: 0,
                          padding: EdgeInsets.only(right: 16),
                          textColor: Colors.white,
                          splashColor: Colors.grey,
                          onPressed: () {
                            showFilterDialog(context,(g,t){
                              print(g +" "+ t);
                            });
                          },
                          child: Icon(
                            Icons.sort,
                            size: 24,
                          ),
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.transparent)),
                        ),
                      ),
                      MaterialButton(
                        minWidth: 0,
                        padding: EdgeInsets.only(right: 16),
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
        ));
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
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Text(
                      _notificationCount > 9
                          ? "+9"
                          : _notificationCount.toString(),
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
