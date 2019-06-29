import 'package:flutter/material.dart';
import 'package:vote_app/utils/utils.dart';
import 'package:vote_app/votestatistics/votestatisticsscreen_controller.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:vote_app/utils/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class VoteStatisticsScreen extends StatefulWidget {
  static const routeName = '/votestatistics';

  @override
  State<StatefulWidget> createState() => VoteStatisticsScreenState();
}

class VoteStatisticsScreenState extends State<VoteStatisticsScreen> {
  GlobalKey<AnimatedCircularChartState> _chartKey;

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
    var width = MediaQuery.of(context).size.width;
    var size = width - (width - vote.title.length * 16);
    if (size > (width) / 2) {
      size = (width - 120) / 2;
    }
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
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                      ),
                      new ClipOval(child: loadImage(vote.type.logo)),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                      ),
                      Container(
                        width: size,
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
      _voteStatisticsScreenController.getDetails(vote.id);
      return buildLoader();
    } else {
      if (voteDetails != null)
        return ListView(children: <Widget>[
          buildVoteDetails(
              context,
              VoteDetailResponse(
                  group: Group(name: voteDetails.group.name),
                  description: voteDetails.description)),
          if (voteDetails.results != null)
            if (voteDetails.results.isNotEmpty) _buildVoteResult()
        ]);
      else
        return Center(
          child: Text(
            "No Data Available",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        );
    }
  }

  Widget _buildVoteResult() {
    var size = MediaQuery.of(context).size.width / 1.5;
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
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
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
                  buildCharts(size, 0, true),
                  buildMoreResults(voteDetails.results, size),
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
    showErrorDialog(context, message);
  }

  void setDetails(VoteDetailResponse resonse) {
    setState(() {
      isLoading = false;
      voteDetails = resonse;
    });
  }

  _buildChips(Color color, String title, String desc) {
    return GestureDetector(
      child: Chip(
        backgroundColor: color,
        label: new Text(
          title,
          style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.bold),
        ),
        deleteIcon: Icon(
          Icons.info,
          color: Theme.of(context).primaryColorLight,
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

  buildMoreResults(List<VoteResults> results, double size) {
    var i = 1;
    return Column(
      children: <Widget>[
        for (VoteResults result in results.skip(1))
          ExpansionTile(
            key: Key((result.hashCode + i).toString()),
            title: Text(
              result.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            children: <Widget>[buildCharts(size, i++, false)],
          ),
      ],
    );
  }

  buildCharts(double size, int index, bool needLegende) {
    var chart;
    var dataChart = List<VotesColumnChartItem>();
    var data;
    var r = List<CircularSegmentEntry>();
    var option = voteDetails.results[index].items;
    for (int i = 0; i < option.length; i++) {
      if (option[i].value != 0)
        r.add(CircularSegmentEntry(
            (option[i].value).toDouble(), ChartColors.getColor(i)));
      dataChart.add(VotesColumnChartItem(
          i.toString(), option[i].value, ChartColors.getColor(i)));
    }
    var series = [
      new charts.Series<VotesColumnChartItem, String>(
        id: index.toString(),
        domainFn: (VotesColumnChartItem clickData, _) => clickData.title,
        measureFn: (VotesColumnChartItem clickData, _) => clickData.value,
        colorFn: (VotesColumnChartItem clickData, _) => clickData.color,
        data: dataChart,
      )
    ];
    chart = new charts.BarChart(
      series,
      animate: true,
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 10, color: charts.MaterialPalette.transparent),
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.transparent))),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 16, color: charts.MaterialPalette.white))),
      defaultInteractions: false,
    );
    data = <CircularStackEntry>[
      new CircularStackEntry(
        r,
        rankKey: 'Quarterly Profits',
      ),
    ];
    _chartKey = new GlobalKey<AnimatedCircularChartState>();
    return Column(
      children: <Widget>[
        if (needLegende)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            verticalDirection: VerticalDirection.down,
            spacing: 8.0,
            runSpacing: 4.0,
            children: <Widget>[
              for (int i = 0; i < option.length; i++)
                _buildChips(ChartColors.getColor(i), option[i].label,
                    option[i].value.toString()),
            ],
          ),
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 0),
          child: Center(
              child: new AnimatedCircularChart(
            key: _chartKey,
            size: Size(size, size),
            initialChartData: data,
            chartType: CircularChartType.Radial,
          )),
        ),
        Padding(
          padding: new EdgeInsets.all(32.0),
          child: new SizedBox(
            height: 200.0,
            child: chart,
          ),
        ),
      ],
    );
  }
}

class VotesColumnChartItem {
  final String title;
  final int value;
  final charts.Color color;

  VotesColumnChartItem(this.title, this.value, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class ChartColors {
  static getColor(index) {
    List<Color> colors = [
      Colors.amber[300],
      Colors.purple[300],
      Colors.blue[300],
      Colors.teal[300],
      Colors.yellow[300],
      Colors.orange[300],
      Colors.red[300],
    ];
    if (index < colors.length) return colors[index];
    return colors[0];
  }
}
