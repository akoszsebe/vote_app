import 'package:flutter/material.dart';
import 'package:vote_app/notification/notificationscreen_controller.dart';
import 'package:vote_app/networking/response/notification_response.dart';
import 'package:vote_app/notification/listitems/notification_listitem.dart';
import 'package:vote_app/utils/widgets.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notifications';

  @override
  State<StatefulWidget> createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<NotificationResponse> notifications;
  NotificationScreenController _notificationScreenController;

  @override
  void initState() {
    super.initState();
    _notificationScreenController =
        NotificationScreenController(notificationScreenState: this);
    _notificationScreenController.init();
  }

  void addNotifications(List<NotificationResponse> notifications) {
    if (this.notifications == null) {
      this.notifications = List<NotificationResponse>();
    }
    setState(() {
      this.notifications.addAll(notifications);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 100.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("Notifications",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          )),
                      background:
                          Container(color: Theme.of(context).primaryColor)),
                ),
              ];
            },
            body: DarkRefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _notificationScreenController.refresh,
                child: _buildBody(notifications))));
  }

  Widget _buildBody(List<NotificationResponse> notifications) {
    if (notifications == null) return buildLoader();
    if (notifications.isEmpty) return _buildNoNotifications();
    return _buildNotifications();
  }

  Widget _buildNotifications() {
    return Container(
        decoration: new BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
            boxShadow: [
              new BoxShadow(
                  color: Colors.black38,
                  offset: new Offset(1.0, 1.0),
                  blurRadius: 5.0)
            ]),
        alignment: Alignment.centerLeft,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return NotificationListItem(
              actions: notifications[index].actions,
              title: notifications[index].message,
              id: notifications[index].id,
            );
          },
          itemCount: notifications.length,
        ));
  }

  Widget _buildNoNotifications() {
    return ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: ListView(padding: EdgeInsets.only(top: 140), children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70.0,
                child: Icon(
                  Icons.notifications_none,
                  color: Theme.of(context).accentColor,
                  size: 70.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 48),
              ),
              Text(
                "No notification",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          )
        ]));
  }
}
