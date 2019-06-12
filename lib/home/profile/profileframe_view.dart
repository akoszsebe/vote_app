import 'package:flutter/material.dart';
import 'package:vote_app/groupinfo/groupinfoscreen_view.dart';
import 'package:vote_app/home/profile/profileframe_controller.dart';
import 'package:vote_app/networking/response/group_response.dart';
import 'package:vote_app/splash/splashscreen_view.dart';
import 'package:vote_app/utils/shared_prefs.dart';
import 'package:vote_app/utils/widgets.dart';

class ProfileFrame extends StatefulWidget {
  static const routeName = '/uppcoming';

  @override
  State<StatefulWidget> createState() => ProfileFrameState();
}

class ProfileFrameState extends State<ProfileFrame> {
  String userName = "";
  String email = "";

  List<GroupResponse> groups;

  ProfileScreenController _profileScreenController;

  @override
  void initState() {
    super.initState();
    _profileScreenController = ProfileScreenController(profileFrameState: this);
    _profileScreenController.init();
  }

  void setName(String userName) {
    setState(() {
      this.userName = userName;
    });
  }

  void setGroups(List<GroupResponse> groups) {
    setState(() {
      this.groups = groups;
    });
  }

  void setEmail(String email) {
    setState(() {
      this.email = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildPersonalInfo(),
        _buildGrupesInfo(),
        _buildAbout()
      ],
    );
  }

  Widget _buildGrupesInfo() {
    return Container(
        alignment: Alignment.centerLeft,
        margin: new EdgeInsets.only(left: 16.0, right: 16),
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
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(top: 8.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "Joined Groups",
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _buildGroup(groups),
          ],
        ));
  }

  Widget _buildPersonalInfo() {
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
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40.0,
                      child: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).accentColor,
                        size: 60.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                    ),
                    new Text(
                      userName,
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                    ),
                    new Text(
                      email,
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white70),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                    ),
                    RoundRaisedButton(
                        onPressed: () {
                          SharedPrefs.setLogedIn(false);
                          Navigator.pushReplacementNamed(
                              context, SplashScreen.routeName);
                        },
                        context: context,
                        child: new Text(
                          "Logout",
                        ))
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildAbout() {
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
                    "About Team",
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _createPersonInfo(
                          "Jozsa Tibold", "Web", "assets/tibold.jpg"),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                      ),
                      _createPersonInfo(
                          "Solyom Ferenc", "Blockchain", "assets/feco.jpg"),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                      ),
                      _createPersonInfo(
                          "Zsebe Akos", "Mobile", "assets/akos.jpg")
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _createPersonInfo(String name, String role, String pic) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: ExactAssetImage(pic),
          radius: 30.0,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
        ),
        new Text(
          name,
          style: new TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6),
        ),
        new Text(
          role,
          style: new TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildGroup(List<GroupResponse> groups) {
    if (groups == null) {
      return buildLoader();
    }
    if (groups.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              width: 300,
              child: Text("No Joined groups to join one needs invitation",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white70))),
          Padding(
            padding: EdgeInsets.only(top: 16),
          ),
        ],
      );
    } else {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines
        children: <Widget>[
          for (var element in groups) _buildChip(element),
        ],
      );
    }
  }

  Widget _buildChip(GroupResponse group) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, GroupInfoScreen.routeName,arguments: group);
      },
      child: Chip(
        backgroundColor: Colors.white,
        label: new Text(
          group.name,
          style: TextStyle(
              color: Colors.blueGrey[700], fontWeight: FontWeight.bold),
        ),
        deleteIcon: Icon(Icons.close),
        deleteIconColor: Theme.of(context).accentColor,
        onDeleted: () {
          showConfirmDialog(
              context, "Alert", "Are you sure you want to disconnect from '${group.name}' group ?",(){
                
              });
        },
      ),
    );
  }
}
