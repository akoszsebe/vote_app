import 'package:flutter/material.dart';
import 'package:vote_app/home/finished/finishedframe_controller.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:vote_app/votestatistics/votestatisticsscreen_view.dart';
import 'package:vote_app/utils/widgets.dart';

class FinishedFrame extends StatefulWidget {
  static const routeName = '/finished';

  @override
  State<StatefulWidget> createState() => FinishedFrameState();
}

class FinishedFrameState extends State<FinishedFrame> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<FinishedVoteResponse> data = [];
  bool isLoading = true;
  FinishedFrameCrontroller _finishedFrameCrontroller;

  @override
  void initState() {
    super.initState();
    _finishedFrameCrontroller =
        FinishedFrameCrontroller(finishedFrameState: this);
    _finishedFrameCrontroller.init();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return buildLoader();
    return DarkRefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _finishedFrameCrontroller.refresh,
      child: ListView.builder(
        itemBuilder: (context, index) =>
            buildFinishedListItem(context, index, data, () {
              Navigator.pushNamed(context, VoteStatisticsScreen.routeName,
                  arguments: data[index]);
            }),
        itemCount: data.length,
      ),
    );
  }

  void setData(List<FinishedVoteResponse> response) {
    setState(() {
      isLoading = false;
      data = response;
    });
  }

  void showError(message) {
    showErrorDialog(context, message);
  }
}
