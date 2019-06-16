import 'package:flutter/material.dart';
import 'package:vote_app/groupinfo/groupinfoscreen_controller.dart';
import 'package:vote_app/networking/response/group_response.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:vote_app/utils/utils.dart';
import 'package:vote_app/utils/widgets.dart';
import 'package:vote_app/vote/votescreen_view.dart';
import 'package:vote_app/votestatistics/votestatisticsscreen_view.dart';

class GroupInfoScreen extends StatefulWidget {
  static const routeName = '/groupinfo';

  @override
  State<StatefulWidget> createState() => GroupInfoScreenState();
}

class GroupInfoScreenState extends State<GroupInfoScreen> {
  bool isLoading = true;
  GroupInfoScreenController _groupInfoScreenController;
  bool requestSent = false;
  GroupResponse groupResponse;
  GroupDetailResponse groupDetailResponse;

  @override
  void initState() {
    super.initState();
    _groupInfoScreenController =
        GroupInfoScreenController(groupInfoScreenState: this);
    _groupInfoScreenController.init();
  }

  @override
  Widget build(BuildContext context) {
    if (!requestSent) {
      groupResponse = ModalRoute.of(context).settings.arguments;
      _groupInfoScreenController.getDetails(groupResponse.id);
      requestSent = true;
    }
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 100.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  groupResponse.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
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
      return ListView(children: <Widget>[
        buildGroupDetails(),
        buildUpcoming(),
        buildFinished()
      ]);
    }
  }

  void showError(message) {
    setState(() {
      isLoading = false;
    });
    showErrorDialog(context, message);
  }

  void setUI(GroupDetailResponse response) {
    setState(() {
      isLoading = false;
      groupDetailResponse = response;
    });
  }

  Widget buildUpcoming() {
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
                      "Upcoming Votes",
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                    ),
                    for (var v in groupDetailResponse.voting.upcoming)
                      _buildUpcomingItem(v),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildFinished() {
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
                      padding: EdgeInsets.only(top: 8),
                    ),
                    new Text(
                      "Finished Votes",
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                    ),
                    for (var v in groupDetailResponse.voting.finished)
                      _buildFinishedItem(v),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildGroupDetails() {
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
                    new ClipOval(
                      child: imageFromBase64String(
                          groupDetailResponse.type.logo, 42),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                    ),
                    new Text(
                      groupDetailResponse.description,
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

  _buildUpcomingItem(VoteResponse v) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new ClipOval(
                  child: imageFromBase64String(v.type.logo, 24),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                ),
                Text(
                  v.title,
                  style: new TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                ),
                Icon(
                  Icons.navigate_next,
                  color: Colors.white70,
                )
              ],
            )),
        onTap: () {
          Navigator.pushNamed(context, VoteScreen.routeName, arguments: v);
        },
      ),
      color: Colors.transparent,
    );
  }

  _buildFinishedItem(FinishedVoteResponse v) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new ClipOval(
                  child: imageFromBase64String(v.type.logo, 24),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                ),
                Text(
                  v.title,
                  style: new TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                ),
                Icon(
                  Icons.navigate_next,
                  color: Colors.white70,
                )
              ],
            )),
        onTap: () {
          Navigator.pushNamed(context, VoteStatisticsScreen.routeName,
              arguments: v);
        },
      ),
      color: Colors.transparent,
    );
  }
}
