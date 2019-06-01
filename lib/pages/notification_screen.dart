import 'package:flutter/material.dart';
import 'package:vote_app/controller/notificationscreen_controller.dart';
import 'package:vote_app/networking/response/notification_response.dart';
import 'package:vote_app/utils/utils.dart';
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

  bool shouldUpdate = true;
  @override
  void initState() {
    super.initState();
    _notificationScreenController =
        NotificationScreenController(notificationScreenState: this);
  }

  void addNotificationItem(NotificationResponse notifcation){
    setState(() {
      notifications.add(notifcation);
    });
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
        body: DarkRefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _notificationScreenController.refresh,
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
    return Container(
        alignment: Alignment.centerLeft,
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).primaryColorLight,
              ),
          itemBuilder: (context, index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              key: Key(notifications[index].id.toString()),
              onDismissed: (direction) {
                print("direction " + direction.toString());
              },
              confirmDismiss: (DismissDirection direction) {
                showConfirmDialog(
                    context, "Alert", "Are you sure to not join this group ?",
                    () {
                  setState(() {
                    notifications.removeAt(index);
                  });
                });
              },
              child: NotificationListItem(
                action: NotificationState.actionNeeded,
                title: notifications[index].message,
              ),
              background: Container(
                color: Colors.red,
                child: Center(
                  child: Text("Delete"),
                ),
              ),
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

class NotificationListItem extends StatefulWidget {
  final NotificationState action;
  final String title;

  NotificationListItem({this.action, this.title});

  @override
  State<StatefulWidget> createState() =>
      _NotificationListItemState(action: action, title: title);
}

enum NotificationState {
  loading,
  actionNeeded,
  actionDone,
}

class _NotificationListItemState extends State<NotificationListItem> {
  NotificationState action;
  String title;
  _NotificationListItemState({this.action, this.title});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
        child: Row(
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
        ));
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
