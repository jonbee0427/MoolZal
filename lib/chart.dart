import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  chart({Key? key}) : super(key: key);

  @override
  _chartState createState() => _chartState();
}

class _chartState extends State<chart> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  String? firtName;
  var secondName;
  var thirdName;
  int? check = 0;

  @override
  void initState() {
    var list = FirebaseFirestore.instance.collection('users').snapshots();

    data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('질문왕 랭킹'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return new Text(
                    'Error in receiving trip photos: ${snapshot.error}');
              }

              var PostsCount = 0;
              List<DocumentSnapshot> itemImages;

              if (snapshot.hasData) {
                itemImages = snapshot.data!.docs;
                PostsCount = itemImages.length;
              }

              if (!snapshot.hasData) {
                return Center(child: Text("NO DATA", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),);
              }

              if (check == 0) {
                check = 1;
                return Center(child: CircularProgressIndicator());
              }

              int len = snapshot.data!.docs.length;
              List<String> names = ["NS"];
              for (int i = 0; i < len; i++) {
                names.add(snapshot.data!.docs[i]['name']);
              }
              names.remove("NS");
              List<int> count = [-1];
              for (int i = 0; i < len; i++) {
                count.add(snapshot.data!.docs[i]['posts'].length);
              }
              count.remove(-1);
              int temp = 0;
              String Stemp = 'temp';
              for (int i = 0; i < len; i++) {
                for (int j = 0; j < len - 1; j++) {
                  if (count[j] > count[j + 1]) {
                    temp = count[j + 1];
                    count[j + 1] = count[j];
                    count[j] = temp;

                    Stemp = names[j + 1];
                    names[j + 1] = names[j];
                    names[j] = Stemp;
                  }
                }
              }
              data = [
                _ChartData(names[len - 3], count[len - 3].toDouble()),
                _ChartData(names[len - 2], count[len - 2].toDouble()),
                _ChartData(names[len - 1], count[len - 1].toDouble()),
              ];
              check = 12;

              if (check == 12) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis:
                            NumericAxis(minimum: 0, maximum: 10, interval: 2),
                        tooltipBehavior: _tooltip,
                        series: <ChartSeries<_ChartData, String>>[
                          ColumnSeries<_ChartData, String>(
                              dataSource: data,
                              xValueMapper: (_ChartData data, _) => data.x,
                              yValueMapper: (_ChartData data, _) => data.y,
                              name: 'Questions',
                              color: Colors.deepPurple)
                        ]),
                    Container(
                      child: Text("---질문왕---",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Container(
                      child: Text('1등 ' + names[len - 1],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Container(
                      child: Text('2등 ' + names[len - 2],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Container(
                      child: Text('3등 ' + names[len - 3],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
