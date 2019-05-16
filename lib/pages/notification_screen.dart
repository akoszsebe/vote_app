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
        body: Center(child: Text("No notifications")));
  }
}
