import 'package:flutter/material.dart';
import 'package:vote_app/groupinfo/groupinfoscreen_view.dart';
import 'package:vote_app/home/profile/profileframe_controller.dart';
import 'package:vote_app/networking/response/group_response.dart';
import 'package:vote_app/splash/splashscreen_view.dart';
import 'package:vote_app/utils/shared_prefs.dart';
import 'package:vote_app/utils/utils.dart';
import 'package:vote_app/utils/widgets.dart';

class ProfileFrame extends StatefulWidget {
  static const routeName = '/uppcoming';

  @override
  State<StatefulWidget> createState() => ProfileFrameState();
}

class ProfileFrameState extends State<ProfileFrame> {
  String userName = "";
  String email = "";
  bool editMode = false;
  Image image;
  bool loading = true;

  List<GroupResponse> groups;

  ProfileScreenController _profileScreenController;

  @override
  void initState() {
    super.initState();
    _profileScreenController = ProfileScreenController(profileFrameState: this);
    _profileScreenController.init();
  }

  void setUserInfo(String userName, String image, String email) {
    setState(() {
      loading = false;
      this.userName = userName;
      if (image.isNotEmpty) {
        this.image = imageFromBase64String(image, 120);
      }
      this.email = email;
    });
  }

  void setGroups(List<GroupResponse> groups) {
    setState(() {
      this.groups = groups;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: ListView(
          children: <Widget>[
            _buildPersonalInfo(),
            _buildGrupesInfo(),
            _buildAbout()
          ],
        ));
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
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 42,
                          ),
                          Expanded(flex: 1, child: _buildImage()),
                          Container(
                            width: 42,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(34.0)),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                      editMode ? Icons.save : Icons.edit,
                                      color: Colors.white),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (editMode) {
                                      loading = true;
                                      _profileScreenController
                                          .updateProfilePic();
                                    }
                                    editMode = !editMode;
                                  });
                                },
                              ),
                            ),
                          ),
                        ]),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                    ),
                    if (loading)
                      buildLoader()
                    else
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
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
                          ]),
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
                          style: TextStyle(fontWeight: FontWeight.bold),
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
        Container(
          width: 62.0,
          height: 62.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: ExactAssetImage(pic),
              fit: BoxFit.cover,
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(31.0)),
            border: new Border.all(
              color: Colors.blueGrey,//Theme.of(context).accentColor,
              width: 2.0,
            ),
          ),
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
        Navigator.pushNamed(context, GroupInfoScreen.routeName,
            arguments: group);
      },
      child: Chip(
        backgroundColor: Colors.white,
        label: new Text(
          group.name,
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
        ),
        deleteIcon: Icon(Icons.close),
        deleteIconColor: Theme.of(context).primaryColorLight,
        onDeleted: () {
          showConfirmDialog(
              context,
              "Alert",
              "Are you sure you want to disconnect from '${group.name}' group ?",
              () {});
        },
      ),
    );
  }

  _buildImage() {
    if (editMode) {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Center(
            child: image == null
                ? Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(60.0)),
                      border: new Border.all(
                        color: Theme.of(context).accentColor,
                        width: 2.0,
                      ),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).accentColor,
                      size: 70.0,
                    ),
                  )
                : Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: image.image,
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(60.0)),
                      border: new Border.all(
                        color: Theme.of(context).accentColor,
                        width: 3.0,
                      ),
                    ),
                  ),
          ),
          Transform.translate(
            offset: const Offset(40, 40.0),
            child: FloatingActionButton(
              mini: true,
              onPressed: _profileScreenController.getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.photo_camera),
            ),
          ),
        ],
      );
    }
    return Center(
      child: image == null
          ? Container(
              width: 120.0,
              height: 120.0,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(new Radius.circular(60.0)),
                border: new Border.all(
                  color: Colors.blueGrey,//Theme.of(context).accentColor,
                  width: 2.0,
                ),
              ),
              child: Icon(
                Icons.person_outline,
                color: Theme.of(context).accentColor,
                size: 70.0,
              ),
            )
          : Container(
              width: 120.0,
              height: 120.0,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: image.image,
                  fit: BoxFit.cover,
                ),
                borderRadius: new BorderRadius.all(new Radius.circular(60.0)),
                border: new Border.all(
                  color: Colors.blueGrey,//Theme.of(context).accentColor,
                  width: 3.0,
                ),
              ),
            ),
    );
  }

  void setImage(Image image) {
    setState(() {
      this.image = image;
    });
  }

  void stopLoader() {
    setState(() {
      this.loading = false;
    });
  }

  void showError(message) {
    showError(message);
  }
}
