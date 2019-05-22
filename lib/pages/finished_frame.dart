import 'package:flutter/material.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:vote_app/utils/utils.dart';
import 'package:vote_app/utils/widgets.dart';

class FinishedFrame extends StatefulWidget {
  static const routeName = '/finished';

  @override
  State<StatefulWidget> createState() => _FinishedFrameFrameState();
}

class _FinishedFrameFrameState extends State<FinishedFrame> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
final List<VoteModel> data = [
    VoteModel("Party", "2019-05-12", "Friends \nWinner: Flying Circus",
        IconType.party, "finished"),
  ];


  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return DarkRefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView.builder(
        itemBuilder: (context,index) => buildListItem(context, index, data, true),
        itemCount: data.length,
      ),
    );
  }

  Future<dynamic> _refresh() async {
    return null;
  }
}
