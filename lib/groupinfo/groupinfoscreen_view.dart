import 'package:flutter/material.dart';
import 'package:vote_app/groupinfo/groupinfoscreen_controller.dart';
import 'package:vote_app/networking/response/group_response.dart';
import 'package:vote_app/utils/widgets.dart';

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
                    fontSize: 18.0,
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
        Text("Group"),
      ]);
    }
  }

  void showError(message) {
    setState(() {
      isLoading = false;
    });
    showAlertDialog(context, "Error", message);
  }
}
