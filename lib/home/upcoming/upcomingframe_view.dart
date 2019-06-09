import 'package:flutter/material.dart';
import 'package:vote_app/home/upcoming/upcomingframe_controller.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:vote_app/utils/widgets.dart';
import 'package:vote_app/vote/votescreen_view.dart';

class UpcomingFrame extends StatefulWidget {
  static const routeName = '/uppcoming';

  @override
  State<StatefulWidget> createState() => UpcomingFrameState();
}

class UpcomingFrameState extends State<UpcomingFrame> {
  List<VoteResponse> data = [];

  bool isLoading = true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  UpComingFrameCrontroller _upcomingFrameCrontroller;

  @override
  void initState() {
    super.initState();
    _upcomingFrameCrontroller =
        UpComingFrameCrontroller(upcomingFrameState: this);
    _upcomingFrameCrontroller.init();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return buildLoader();
    return DarkRefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _upcomingFrameCrontroller.refresh,
      child: ListView.builder(
        itemBuilder: (context, index) =>
            buildListItem(context, index, data, () {
              Navigator.pushNamed(context, VoteScreen.routeName,
                  arguments: data[index]);
            }),
        itemCount: data.length,
      ),
    );
  }

  void setData(List<VoteResponse> response) {
    setState(() {
      isLoading = false;
      data = response;
    });
  }

  void showError(message) {
    showAlertDialog(context, "Error", message);
  }
}
