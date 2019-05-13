import 'package:flutter/material.dart';
import 'package:vote_app/networking/response/vote_response.dart';
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
    VoteModel("Party", "2019-05-12", "Created by: Feco \nWinner: Flying Circus",
        Icon(Icons.party_mode, color: Colors.deepOrange), "finished"),
  ];


  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView.builder(
        itemBuilder: (context,index) => buildListItem(context, index, data),
        itemCount: data.length,
      ),
    );
  }

  Future<dynamic> _refresh() async {
    return null;
  }
}
