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



  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((data) =>
        data.docs.forEach((doc) => print(doc["title"])));


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
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                      tooltipBehavior: _tooltip,
                      series: <ChartSeries<_ChartData, String>>[
                        ColumnSeries<_ChartData, String>(
                            dataSource: data,
                            xValueMapper: (_ChartData data, _) => data.x,
                            yValueMapper: (_ChartData data, _) => data.y,
                            name: 'Gold',
                            color: Color.fromRGBO(8, 142, 255, 1))
                      ]
                  ),
                  Container(
                    child: Text("***질문왕***", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Container(
                    child: Text("대충 1등 자리", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Container(
                    child: Text("대충 2등 자리", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Container(
                    child: Text("대충 3등 자리", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ]
            )
        )
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}