import 'package:flutter/material.dart';
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


  Widget buildLoader() {
    return Center(
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)));
  }

Widget buildListItem(BuildContext context,int index,List<VoteModel> data) {
return
  InkWell(
        onTap: () {
          showAlertDialog(context, "Info", "not available jet ");
        },
        child: Container(
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
              new CircleAvatar(
                backgroundColor: Colors.white70,
                child: data[index].icon,
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
                      data[index].date,
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
                data[index].joined,
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
            ],
          ),
        ));
}