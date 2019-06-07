import 'package:flutter/material.dart';
import 'package:vote_app/groupinfo/groupinfoscreen_controller.dart';
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

  @override
  void initState() {
    super.initState();
    _groupInfoScreenController = GroupInfoScreenController(groupInfoScreenState: this);
    _groupInfoScreenController.init();
  }

  @override
  Widget build(BuildContext context) {
    if (!requestSent) {
      //groupeId = ModalRoute.of(context).settings.arguments;
      requestSent = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8),
          ),
          Text("Groop")
        ]),
      ),
      body: _buildBody(),
    );
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
