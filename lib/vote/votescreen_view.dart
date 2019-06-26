import 'package:flutter/material.dart';
import 'package:vote_app/utils/utils.dart';
import 'package:vote_app/vote/votescreen_controller.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:vote_app/utils/widgets.dart';

class VoteScreen extends StatefulWidget {
  static const routeName = '/vote';

  @override
  State<StatefulWidget> createState() => VoteScreenState();
}

class VoteScreenState extends State<VoteScreen> {
  int _radioValue = -1;
  VoteResponse vote;
  VoteDetailResponse voteDetails;
  bool isLoading = true;
  VoteSreenController _voteSreenController;
  bool requestSent = false;
  Image image;
  VoteAction action;

  @override
  void initState() {
    super.initState();
    action = VoteAction.ACTION;
    _voteSreenController = VoteSreenController(voteScreenState: this);
    _voteSreenController.init();
  }

  void setRadioValue(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!requestSent) {
      vote = ModalRoute.of(context).settings.arguments;
      _voteSreenController.getVotedetails(vote.id);
      requestSent = true;
    }
    var width = MediaQuery.of(context).size.width;
    var size = width - (width - vote.title.length * 16);
    print("--Start--");
    print(width);
    print(size);
    print((width) / 2);
    if (size > (width) / 2) {
      size = (width - 120) / 2;
    }
    print(size);
    print("--Stop--");
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 100.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(bottom: 8),
                centerTitle: true,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                      ),
                      new ClipOval(child: loadImage(vote.type.logo)),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                      ),
                      Container(
                        width: size,
                        child: Text(vote.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            )),
                      )
                    ]),
                background: Container(color: Theme.of(context).primaryColor)),
          ),
        ];
      },
      body: _buildBody(),
    ));
  }

  Widget _buildBody() {
    if (isLoading) {
      return buildLoader();
    } else {
      if (voteDetails != null)
        return ListView(children: <Widget>[
          buildVoteDetails(context, voteDetails),
          _buildVoteOptions(voteDetails)
        ]);
      else
        return Center(
          child: Text(
            "No Data Available",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        );
    }
  }

  Widget _buildVoteOptions(VoteDetailResponse voteDetails) {
    Color color = HexColor(vote.type.color);
    return Container(
        alignment: Alignment.centerLeft,
        margin: new EdgeInsets.all(16.0),
        padding: new EdgeInsets.all(8.0),
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
                        color: color,
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        for (int i = 0; i < voteDetails.responses.length; i++)
                          radioElement(
                              voteDetails.responses[i].value,
                              voteDetails.responses[i].description,
                              voteDetails.responses[i].id,
                              _voteSreenController.handleRadioValueChange,
                              color),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                        ),
                        _buildAction(color)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget radioElement(
      String title, String desc, int value, Function listner, Color color) {
    return new Container(
        padding: EdgeInsets.only(left: 8),
        child: Column(
          children: <Widget>[
            new Row(
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
            if (desc.isNotEmpty)
              Container(
                width: MediaQuery.of(context).size.width - 92,
                child: new Text(
                  desc,
                  style: new TextStyle(fontSize: 14.0, color: Colors.white70),
                ),
              ),
          ],
        ));
  }

  void showError(message) {
    setState(() {
      isLoading = false;
    });
    showErrorDialog(context, message);
  }

  void setVoteDetails(VoteDetailResponse response) {
    setState(() {
      isLoading = false;
      voteDetails = response;
    });
  }

  Image loadImage(String logo) {
    if (image == null) {
      image = imageFromBase64String(logo, 42);
    }
    return image;
  }

  _buildAction(Color color) {
    switch (action) {
      case VoteAction.ACTION:
        return RoundColoredRaisedButton(
            onPressed: () {
              setState(() {
                action = VoteAction.LOADING;
              });

              _voteSreenController.verifyVote(
                  vote.id.toString(), _radioValue.toString());
              //_voteSreenController.vote();
            },
            textColor: color,
            child: new Text(
              "Vote",
            ));
      case VoteAction.LOADING:
        return buildLoader();
      case VoteAction.VERIFY:
        return Text("verified");
    }
    return buildLoader();
  }

  void valid() {
    setState(() {
      action = VoteAction.VERIFY;
    });
  }

  void setLoading() {
    setState(() {
      action = VoteAction.ACTION;
    });
  }
}

enum VoteAction { ACTION, LOADING, VERIFY }
