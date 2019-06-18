import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vote_app/home/filter_dialog.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:vote_app/utils/utils.dart';

void showErrorDialog(BuildContext context, String error) {
  showAlertDialog(context, "OOPS!", "Something went wrong: " + error);
}

void showAlertDialog(BuildContext context, String title, String content) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
            child: new Text(
          title,
          style: TextStyle(color: Colors.white),
        )),
        content: new Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
        actions: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width - 96,
              child: Center(
                child: new FlatButton(
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )),
        ],
      );
    },
  );
}

void showFilterDialog(BuildContext context, List<String> _dropdownValuesGroup,List<String> _dropdownValuesType) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
            child: new Text(
          "Filter",
          style: TextStyle(color: Colors.white),
        )),
        content: FilterDialog(dropdownValuesGroup: _dropdownValuesGroup,dropdownValuesType: _dropdownValuesType),
        actions: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width - 96,
              child: Center(
                child: new FlatButton(
                  child: new Text("Apply"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )),
        ],
      );
    },
  );
}

void showConfirmDialog(
    BuildContext context, String title, String content, VoidCallback onOK) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
            child: new Text(
          title,
          style: TextStyle(color: Colors.white),
        )),
        content: new Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
        actions: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width - 96,
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Container(
                      height: 20.0,
                      width: 1.0,
                      color: Colors.white30,
                      margin: const EdgeInsets.only(left: 25.0, right: 15.0),
                    ),
                    new FlatButton(
                      child: new Text("Ok"),
                      onPressed: () {
                        onOK();
                        Navigator.of(context).pop();
                      },
                    ),
                  ])),
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

Widget buildListItem(BuildContext context, int index, List<VoteResponse> data,
    VoidCallback onTap) {
  var format = new DateFormat("yMd");
  var date = DateTime.fromMillisecondsSinceEpoch(data[index].beginning);
  var days = date.difference(DateTime.now()).inDays;
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
            new ClipOval(
              child: imageFromBase64String(
                  data[index].type.logo, 48), //data[index].type.logo,
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
                    format.format(date),
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  ),
                  new Text(
                    data[index].group,
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

Widget buildFinishedListItem(BuildContext context, int index,
    List<FinishedVoteResponse> data, VoidCallback onTap) {
  var format = new DateFormat("yMd");
  var date = DateTime.fromMillisecondsSinceEpoch(data[index].end);
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
            new ClipOval(
              child: imageFromBase64String(
                  data[index].type.logo, 48), //data[index].type.logo,
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
                    format.format(date),
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  ),
                  new Text(
                    data[index].group,
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
