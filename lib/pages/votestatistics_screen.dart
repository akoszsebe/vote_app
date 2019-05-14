import 'package:flutter/material.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

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
        new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
        new CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
        new CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
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
        title: Text(vote.title),
      ),
      body: Center(
          child: new AnimatedCircularChart(
        key: _chartKey,
        size: const Size(300.0, 300.0),
        initialChartData: data,
        chartType: CircularChartType.Radial,
      )),
    );
  }
}
