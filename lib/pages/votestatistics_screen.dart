import 'package:flutter/material.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:vote_app/utils/widgets.dart';

class VoteStatisticsScreen extends StatefulWidget {
  static const routeName = '/votestatistics';

  @override
  State<StatefulWidget> createState() => _VoteStatisticsScreenState();
}

class _VoteStatisticsScreenState extends State<VoteStatisticsScreen> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(500.0, Colors.red[400], rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Colors.green[400], rankKey: 'Q2'),
        new CircularSegmentEntry(2000.0, Colors.blue[400], rankKey: 'Q3'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final VoteModel vote = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Row(children: <Widget>[
          CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20.0,
              child: Icon(
                vote.icon.icon,
                size: 18.0,
                color: vote.icon.color,
              )),
          Padding(
            padding: EdgeInsets.only(left: 8),
          ),
          Text(vote.title)
        ]),
      ),
      body: ListView(
        children: <Widget>[buildVoteDetails(vote), _buildVoteResult(vote)],
      ),
    );
  }

  Widget _buildVoteResult(VoteModel vote) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: new EdgeInsets.all(16.0),
        padding: new EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
            color: Colors.blueGrey,
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
                    "Result",
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  SizedBox(
                    height: 5,
                    width: 25,
                    child: Container(
                      decoration: new BoxDecoration(
                        color: vote.icon.color,
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: data[0].entries[0].color,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 8),
                        child: Text(
                          "After8",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: data[0].entries[1].color,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 8),
                        child: Text(
                          "/Form",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: data[0].entries[2].color,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 8),
                        child: Text(
                          "Flying",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 0),
                    child: Center(
                        child: new AnimatedCircularChart(
                      key: _chartKey,
                      size: const Size(300.0, 300.0),
                      initialChartData: data,
                      chartType: CircularChartType.Radial,
                    )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
