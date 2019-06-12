import 'package:flutter/material.dart';
import 'package:vote_app/networking/response/notification_response.dart';
import 'package:vote_app/notification/listitems/notification_listitem_controller.dart';
import 'package:vote_app/utils/widgets.dart';

class NotificationListItem extends StatefulWidget {
  final List<NotAction> actions;
  final String title;
  final int id;

  NotificationListItem({this.actions, this.title, this.id});

  @override
  State<StatefulWidget> createState() =>
      NotificationListItemState(actions: actions, title: title, id: id);
}

class NotificationListItemState extends State<NotificationListItem> {
  List<NotAction> actions;
  String title;
  int id;

  NotificationListItemController _notificationListItemController;
  bool isLoading = false;

  NotificationListItemState({this.actions, this.title, this.id});
  @override
  void initState() {
    super.initState();
    _notificationListItemController =
        NotificationListItemController(notificationListItemState: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
        padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
        decoration: new BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
            boxShadow: [
              new BoxShadow(
                  color: Colors.black38,
                  offset: new Offset(1.0, 1.0),
                  blurRadius: 5.0)
            ]),
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
          RoundRaisedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                _notificationListItemController.joinGroup(id);
              },
              context: context,
              child: Text(
                "Join",
              )),
        if (actions.contains(NotAction.ACTION_DECLINE))
          RoundRaisedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                _notificationListItemController.notJoinGroup(id);
              },
              context: context,
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

  void accepted() {
    setState(() {
      isLoading = false;
      actions.clear();
      actions.add(NotAction.ACTION_OPEN);
    });
  }

  void rejected() {
    setState(() {
      isLoading = false;
      actions.clear();
    });
  }

  void onError(error) {
    setState(() {
      isLoading = false;
    });
    showErrorDialog(context, error.message);
  }
}
