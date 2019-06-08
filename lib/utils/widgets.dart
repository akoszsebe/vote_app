import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vote_app/networking/response/vote_response.dart';

void showAlertDialog(BuildContext context, String title, String content) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showConfirmDialog(
    BuildContext context, String title, String content, VoidCallback onOK) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              onOK();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget buildLoader() {
  return Center(
      child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)));
}

Widget buildListItem(
    BuildContext context, int index, List<VoteModel> data, VoidCallback onTap) {
  var format = new DateFormat("yMd");
  var days = data[index].date.difference(DateTime.now()).inDays;
  return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: new EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
        padding: new EdgeInsets.all(16.0),
        decoration: new BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
            boxShadow: [
              new BoxShadow(
                  color: Colors.black38,
                  offset: new Offset(1.0, 1.0),
                  blurRadius: 5.0)
            ]),
        child: new Row(
          children: <Widget>[
            new CircleAvatar(
              backgroundColor: Colors.white,
              child: data[index].voteIcon.icon,
              radius: 20.0,
            ),
            new Expanded(
                child: new Padding(
              padding: new EdgeInsets.only(left: 16.0, top: 8.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    data[index].title,
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  ),
                  new Text(
                    format.format(data[index].date),
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  ),
                  new Text(
                    data[index].content,
                    style: new TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  ),
                ],
              ),
            )),
            new Text(
              "Vote in \n" + days.toString() + (days > 1 ? " days" : " day"),
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54),
            ),
          ],
        ),
      ));
}

Widget buildVoteDetails(BuildContext context, VoteDetailResponse vote) {
  return Container(
      alignment: Alignment.centerLeft,
      margin: new EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
      padding: new EdgeInsets.all(16.0),
      decoration: new BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          boxShadow: [
            new BoxShadow(
                color: Colors.black38,
                offset: new Offset(1.0, 1.0),
                blurRadius: 5.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: new EdgeInsets.only(top: 8.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 6),
                  ),
                  new Text(
                    vote.group.name,
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                  ),
                  new Text(
                    vote.description,
                    style: new TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ));
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class RoundRaisedButton extends RaisedButton {
  RoundRaisedButton(
      {VoidCallback onPressed, BuildContext context, Widget child})
      : super(
            onPressed: onPressed,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            textColor: Theme.of(context).accentColor,
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: child);
}

class RoundColoredRaisedButton extends RaisedButton {
  RoundColoredRaisedButton(
      {VoidCallback onPressed, Color textColor, Widget child})
      : super(
            onPressed: onPressed,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            textColor: textColor,
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: child);
}

class RoundInvertedRaisedButton extends RaisedButton {
  RoundInvertedRaisedButton(
      {VoidCallback onPressed, BuildContext context, Widget child})
      : super(
            onPressed: onPressed,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            textColor: Colors.white,
            color: Theme.of(context).accentColor,
            padding: const EdgeInsets.all(8.0),
            child: child);
}

class DarkRefreshIndicator extends RefreshIndicator {
  DarkRefreshIndicator({
    Key key,
    @required Widget child,
    double displacement = 40.0,
    @required RefreshCallback onRefresh,
    Color color = Colors.white,
    ScrollNotificationPredicate notificationPredicate =
        defaultScrollNotificationPredicate,
    String semanticsLabel,
    String semanticsValue,
  }) : super(
            key: key,
            child: child,
            displacement: displacement,
            onRefresh: onRefresh,
            color: color,
            backgroundColor: Colors.blueGrey[600],
            notificationPredicate: notificationPredicate,
            semanticsLabel: semanticsLabel,
            semanticsValue: semanticsValue);
}
