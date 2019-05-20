import 'package:flutter/material.dart';
import 'package:vote_app/utils/widgets.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notifications';

  @override
  State<StatefulWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        body: ListView(
          children: <Widget>[
            NotificationListItem(action: NotificationState.actionNeeded),
            NotificationListItem(action: NotificationState.actionDone)
          ],
        ));
  }

  Widget _buildNoNotifications() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
    ));
  }
}

class NotificationListItem extends StatefulWidget {
  final NotificationState action;
  NotificationListItem({this.action});

  @override
  State<StatefulWidget> createState() =>
      _NotificationListItemState(action: action);
}

enum NotificationState {
  loading,
  actionNeeded,
  actionDone,
}

class _NotificationListItemState extends State<NotificationListItem> {
  NotificationState action;
  _NotificationListItemState({this.action});
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
                  "Title",
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
