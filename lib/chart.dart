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

  String ? firtName;
  var secondName;
  var thirdName;



  @override
  void initState() {

    var list = FirebaseFirestore.instance
        .collection('users')
        .snapshots();


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
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return new Text('Error in receiving trip photos: ${snapshot.error}');
              }

              var PostsCount = 0;
              List<DocumentSnapshot>? itemImages;

              if (snapshot.hasData) {
                itemImages = snapshot.data!.docs;
                PostsCount = itemImages.length;
              }
              int len = itemImages!.length;
              List<String> names = ["NS"];
              for(int i =0;i<len;i++){
                names.add(itemImages[i]['name']);
              }
              names.remove("NS");
              List<int> count = [-1];
              for(int i =0;i<len;i++){
                count.add(itemImages[i]['posts'].length);
              }
              count.remove(-1);
              int temp = 0;
              String Stemp = 'temp';
              for(int i=0; i<len ; i++){
                for(int j=0;j<len-1;j++){
                  if(count[j] > count[j+1]){
                    temp = count[j+1];
                    count[j+1] = count[j];
                    count[j] = temp;

                    Stemp = names[j+1];
                    names[j+1] = names[j];
                    names[j] = Stemp;
                  }
                }
              }
              print(len);
              data = [
                _ChartData(names[len-3], count[len-3].toDouble()),
                _ChartData(names[len-2], count[len-2].toDouble()),
                _ChartData(names[len-1], count[len-1].toDouble()),
              ];


              return Column(
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
                            name: 'Questions',
                            color: Colors.deepPurple)
                      ]
                  ),
                  Container(
                    child: Text("***질문왕***", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Container(
                    child: Text('1등 ' + names[len-1], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Container(
                    child: Text('2등 ' + names[len-2], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Container(
                    child: Text('3등 ' + names[len-3], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ],
              );
            }
            )
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}