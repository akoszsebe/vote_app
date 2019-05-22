import 'package:flutter/material.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:vote_app/utils/widgets.dart';

class VoteScreen extends StatefulWidget {
  static const routeName = '/vote';

  @override
  State<StatefulWidget> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  int _radioValue = 0;

  @override
  void initState() {
    super.initState();
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final VoteModel vote = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Row(children: <Widget>[
          CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20.0,
              child: Icon(
                vote.voteIcon.icon.icon,
                size: 18.0,
                color: vote.voteIcon.color,
              )),
          Padding(
            padding: EdgeInsets.only(left: 8),
          ),
          Text(vote.title)
        ]),
      ),
      body: ListView(
        children: <Widget>[buildVoteDetails(vote), _buildVoteOptions(vote)],
      ),
    );
  }

  

  Widget _buildVoteOptions(VoteModel vote) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: new EdgeInsets.all(16.0),
        padding: new EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
            color: Colors.blueGrey,
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
            new Padding(
              padding: new EdgeInsets.only(top: 8.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    "Options",
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  SizedBox(
                    height: 5,
                    width: 25,
                    child: Container(
                      decoration: new BoxDecoration(
                        color: vote.voteIcon.color,
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        radioElement("Kebab", 0, _handleRadioValueChange,
                            vote.voteIcon.color),
                        radioElement("Csirkehus majonezes pityokaval", 1,
                            _handleRadioValueChange, vote.voteIcon.color),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                        ),
                        RaisedButton(
                            onPressed: () {},
                            textColor: vote.voteIcon.color,
                            color: Colors.white,
                            padding: const EdgeInsets.all(8.0),
                            child: new Text(
                              "Vote",
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget radioElement(String title, int value, Function listner, Color color) {
    return new Container(
      padding: EdgeInsets.only(left: 8),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            title,
            style: new TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          new Radio(
            value: value,
            groupValue: _radioValue,
            onChanged: listner,
            activeColor: color,
          ),
        ],
      ),
    );
  }
}
