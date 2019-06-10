import 'dart:math';

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

  List<CircularStackEntry> data;

  FinishedVoteResponse vote;
  VoteDetailResponse voteDetails;
  bool isLoading = true;
  Image image;
  VoteStatisticsScreenController _voteStatisticsScreenController;

  @override
  void initState() {
    super.initState();
    _voteStatisticsScreenController =
        VoteStatisticsScreenController(voteStatisticsScreenState: this);
    _voteStatisticsScreenController.init();
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
                titlePadding: EdgeInsets.only(bottom: 8),
                centerTitle: true,
                title: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      new ClipOval(child: loadImage(vote.type.logo)),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                      ),
                      Text(vote.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          )),
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
      _voteStatisticsScreenController.getDetails(vote.id);
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
                    voteDetails.results[0].title,
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
                    verticalDirection: VerticalDirection.down,
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: <Widget>[
                      for (int i = 0; i <= voteDetails.results.length; i++)
                        _buildChips(
                            data[0].entries[i].color,
                            voteDetails.results[0].items[i].label,
                            voteDetails.results[0].items[i].value.toString()),
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

  Image loadImage(String logo) {
    if (image == null) {
      image = imageFromBase64String(logo, 42);
    }
    return image;
  }

  void showError(message) {
    setState(() {
      isLoading = false;
    });
    showAlertDialog(context, "Error", message);
  }

  void setDetails(VoteDetailResponse resonse) {
    setState(() {
      isLoading = false;
      voteDetails = resonse;

      List<CircularSegmentEntry> r = List<CircularSegmentEntry>();
      var i = 0;
      voteDetails.results[0].items.forEach((option) {
        r.add(CircularSegmentEntry(
            (option.value).toDouble(), ChartColors.getColor(i++),
            rankKey: 'Q1'));
      });
      data = <CircularStackEntry>[
        new CircularStackEntry(
          r,
          rankKey: 'Quarterly Profits',
        ),
      ];
    });
  }

  _buildChips(Color color, String title, String desc) {
    return GestureDetector(
      child: Chip(
        backgroundColor: color,
        label: new Text(
          title,
          style: TextStyle(
              color: Colors.blueGrey[600], fontWeight: FontWeight.bold),
        ),
        deleteIcon: Icon(
          Icons.info,
          color: Colors.blueGrey[600],
        ),
        onDeleted: () {
          showAlertDialog(context, title, desc);
        },
      ),
      onTap: () {
        showAlertDialog(context, title, desc);
      },
    );
  }
}

class ChartColors {
  static final List<Color> colors = [
    Colors.indigo[600],
    Colors.blue[600],
    Colors.lightBlue[600],
    Colors.cyan[600],
    Colors.teal[600],
    Colors.green[600],
    Colors.lightGreen[600],
    Colors.lime[600],
    Colors.yellow[600],
    Colors.amber[600],
    Colors.orange[600],
    Colors.deepOrange[600],
    Colors.brown[600],
    Colors.grey[600],
  ];

  static getColor(index) {
    List<Color> colors = [
      Colors.redAccent,
      Colors.orangeAccent,
      Colors.yellowAccent,
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.purpleAccent,
      Colors.grey,
    ];
    Random r = Random();
    if (index < colors.length) return colors[index];
    return colors[r.nextInt(7)];
  }
}
