import 'package:flutter/material.dart';

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
            _buildNotificationItem(false),
            _buildNotificationItem(true)
          ],
        ));
  }

  Widget _buildNotificationItem(bool action) {
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
          if (action)
            RaisedButton(
                onPressed: () => {},
                textColor: Theme.of(context).accentColor,
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "Join",
                ))
          else
            Text(
              "Joined",
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54),
            ),
        ],
      ),
    );
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
