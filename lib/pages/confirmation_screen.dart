import 'dart:io';
import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  static const routeName = '/confirmation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 130),),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 70.0,
                        child: Icon(
                          Icons.done,
                          color: Theme.of(context).accentColor,
                          size: 70.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          "Registration request sent waiting for data validation",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 34.0),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () => {
                                        {
                                          exit(0)
                                          //Navigator.pop(context)
                                        },
                                      },
                                  textColor: Theme.of(context).accentColor,
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text(
                                    "Exit",
                                  ),
                                ),
                              ]))
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
