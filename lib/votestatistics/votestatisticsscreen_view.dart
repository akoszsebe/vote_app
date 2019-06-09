import 'package:flutter/material.dart';
import 'package:vote_app/utils/utils.dart';
import 'package:vote_app/votestatistics/votestatisticsscreen_controller.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:vote_app/utils/widgets.dart';

class VoteStatisticsScreen extends StatefulWidget {
  static const routeName = '/votestatistics';

  @override
  State<StatefulWidget> createState() => VoteStatisticsScreenState();
}

class VoteStatisticsScreenState extends State<VoteStatisticsScreen> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  FinishedVoteResponse vote;
  bool isLoading = true;
  VoteStatisticsScreenController _voteStatisticsScreenController;

  @override
  void initState() {
    super.initState();
    _voteStatisticsScreenController =
        VoteStatisticsScreenController(voteStatisticsScreenState: this);
    _voteStatisticsScreenController.init();
  }

  void setLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    vote = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 100.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 50, bottom: 8),
                title: Row(children: <Widget>[
                  new ClipOval(
                    child: imageFromBase64String(
                        vote.type.logo, 42), //data[index].type.logo,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 200,
                    child: Text(vote.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        )),
                  )
                ]),
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
        buildVoteDetails(
            context,
            VoteDetailResponse(
                group: Group(name: vote.group), description: "description")),
        _buildVoteResult(vote)
      ]);
    }
  }

  Widget _buildVoteResult(FinishedVoteResponse vote) {
    Color color = HexColor(vote.type.color);
    return Container(
        alignment: Alignment.centerLeft,
        margin: new EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
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
                        color: color,
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                  ),
                  Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0,
                    children: <Widget>[
                      Chip(
                        backgroundColor: data[0].entries[0].color,
                        label: new Text(
                          "Igen",
                          style: TextStyle(
                              color: Colors.blueGrey[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Chip(
                        backgroundColor: data[0].entries[1].color,
                        label: new Text(
                          "Nem",
                          style: TextStyle(
                              color: Colors.blueGrey[700],
                              fontWeight: FontWeight.bold),
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
