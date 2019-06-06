import 'package:flutter/material.dart';
import 'package:vote_app/home/upcoming/upcomingframe_controller.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:vote_app/utils/utils.dart';
import 'package:vote_app/utils/widgets.dart';
import 'package:vote_app/vote/votescreen_view.dart';

class UpcomingFrame extends StatefulWidget {
  static const routeName = '/uppcoming';

  @override
  State<StatefulWidget> createState() => UpcomingFrameState();
}

class UpcomingFrameState extends State<UpcomingFrame> {
  List<VoteModel> data = [
    VoteModel('Food for friday lunch', "2019-05-15", "Accenture", IconType.food,
        "vote"),
    VoteModel('Food for friday morning', "2019-05-16", "Accenture",
        IconType.food, "vote in\n 1 day"),
    VoteModel(
        'Boss', "2019-05-18", "Romania", IconType.election, "vote in\n 1 day"),
    VoteModel('What to sport together', "2019-05-18", "Friends", IconType.sport,
        "vote in\n 2 days")
  ];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  UpComingFrameCrontroller _upcomingFrameCrontroller;

  @override
  void initState() {
    super.initState();
    _upcomingFrameCrontroller =
        UpComingFrameCrontroller(upcomingFrameState: this);
    _upcomingFrameCrontroller.init();

    _upcomingFrameCrontroller.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return DarkRefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _upcomingFrameCrontroller.refresh,
      child: ListView.builder(
        itemBuilder: (context, index) =>
            buildListItem(context, index, data, (){
          Navigator.pushNamed(context, VoteScreen.routeName,
              arguments: data[index]);
      }),
        itemCount: data.length,
      ),
    );
  }

  void setData(List<VoteResponse> response) {
    setState(() {
     //data = response; 
    });
  }
}
