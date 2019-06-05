import 'package:flutter/material.dart';
import 'package:vote_app/controller/notificationscreen_controller.dart';
import 'package:vote_app/networking/providers/group_api_provider.dart';
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
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        body: DarkRefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _notificationScreenController.refresh,
            child: _buildBody(notifications)));
  }

  Widget _buildBody(List<NotificationResponse> notifications) {
    if (notifications == null) return buildLoader();
    if (notifications.isEmpty) return _buildNoNotifications();
    return _buildNotifications();
  }

  Widget _buildNotifications() {
    return Container(
        alignment: Alignment.centerLeft,
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).primaryColorLight,
              ),
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

class NotificationListItem extends StatefulWidget {
  final List<NotAction> actions;
  final String title;
  final int id;

  NotificationListItem({this.actions, this.title, this.id});

  @override
  State<StatefulWidget> createState() =>
      _NotificationListItemState(actions: actions, title: title, id: id);
}

class _NotificationListItemState extends State<NotificationListItem> {
  List<NotAction> actions;
  String title;
  int id;

  bool isLoading = false;

  _NotificationListItemState({this.actions, this.title, this.id});
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
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  )
                ],
              ),
            )),
            _buildAction()
          ],
        ));
  }

  Widget _buildAction() {
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.only(right: 16),
        child: buildLoader(),
      );
    }
    if (actions == null) {
      return Container();
    }
    return Column(
      children: <Widget>[
        if (actions.contains(NotAction.ACTION_ACCEPT))
          RaisedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                joinGroup(id);
              },
              textColor: Theme.of(context).accentColor,
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Join",
              )),
        if (actions.contains(NotAction.ACTION_DECLINE))
          RaisedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                notJoinGroup(id);
              },
              textColor: Theme.of(context).accentColor,
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Reject",
              )),
        if (actions.contains(NotAction.ACTION_OPEN))
          Text(
            "Joined",
            style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white54),
          ),
      ],
    );
  }

  void joinGroup(int id) {
    GroupApiProvider groupApiProvider = GroupApiProvider();
    groupApiProvider.accept(id).then((response) {
      setState(() {
        isLoading = false;
        actions.clear();
        actions.add(NotAction.ACTION_OPEN);
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      showAlertDialog(context, "Error", error.message);
    });
  }

  void notJoinGroup(int id) {
    GroupApiProvider groupApiProvider = GroupApiProvider();
    groupApiProvider.reject(id).then((response) {
      setState(() {
        isLoading = false;
        actions.clear();
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      showAlertDialog(context, "Error", error.message);
    });
  }
}
