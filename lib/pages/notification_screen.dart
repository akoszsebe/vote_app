import 'package:flutter/material.dart';
import 'package:vote_app/networking/response/notification_response.dart';
import 'package:vote_app/utils/utils.dart';
import 'package:vote_app/utils/widgets.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notifications';

  @override
  State<StatefulWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<NotificationResponse> notifications;

  bool shouldUpdate = true;
  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> _refresh() async {
    //notifications = List<NotificationResponse>();
    setState(() {
      notifications.add(NotificationResponse(
          id: 1, message: "mak", notType: "", actions: ["join"]));
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (shouldUpdate) {
      notifications = ModalRoute.of(context).settings.arguments;
      shouldUpdate = false;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refresh,
            child: _buildBody(notifications)));
  }

  Widget _buildBody(List<NotificationResponse> notifications) {
    if (notifications.isEmpty) {
      return _buildNoNotifications();
    } else {
      return _buildNotifications();
    }
  }

  Widget _buildNotifications() {
    return ListView.builder(
      itemBuilder: (context, index){ return NotificationListItem(action: NotificationState.actionNeeded,title: notifications[index].message,);},
      itemCount: notifications.length,
    );
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

class NotificationListItem extends StatefulWidget {
  final NotificationState action;
  final String title;

  NotificationListItem({this.action,this.title});

  @override
  State<StatefulWidget> createState() =>
      _NotificationListItemState(action: action,title: title);
}

enum NotificationState {
  loading,
  actionNeeded,
  actionDone,
}

class _NotificationListItemState extends State<NotificationListItem> {
  NotificationState action;
  String title;
  _NotificationListItemState({this.action,this.title});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: new EdgeInsets.all(16.0),
      padding: new EdgeInsets.all(16.0),
      decoration: new BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          boxShadow: [
            new BoxShadow(
                color: Colors.black38,
                offset: new Offset(1.0, 1.0),
                blurRadius: 5.0)
          ]),
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new Padding(
            padding: new EdgeInsets.only(left: 16.0, top: 8.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  title,
                  style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                ),
                new Text(
                  "Content",
                  style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54),
                ),
              ],
            ),
          )),
          _buildAction()
        ],
      ),
    );
  }

  Widget _buildAction() {
    switch (action) {
      case NotificationState.loading:
        return Padding(
          padding: EdgeInsets.only(right: 16),
          child: buildLoader(),
        );
      case NotificationState.actionNeeded:
        return RaisedButton(
            onPressed: () {
              setState(() {
                action = NotificationState.loading;
              });
            },
            textColor: Theme.of(context).accentColor,
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Join",
            ));
      case NotificationState.actionDone:
        return Text(
          "Joined",
          style: new TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white54),
        );
    }
    return Text(
      "Error",
      style: new TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white54),
    );
  }
}
