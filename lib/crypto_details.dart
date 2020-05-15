import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'coin_data.dart'; 
class ShowDetails extends StatelessWidget{
  
  final String cryptoCurrency;
  final String percentDaily;
  final String percentWeekly;
  final String percentMonthly;
  final String openDaily;
  final String high;
  final String low;
  final String cur;
  ShowDetails(this.cryptoCurrency, this.percentDaily, this.percentWeekly, this.percentMonthly, this.openDaily, this.high, this.low, this.cur);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text( 
          'The CryptoCurrency Project',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Oxygen'),
        )),
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          
          children: <Widget>[
            Container(
              height: 520,
              width: 500,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Hero(
                    tag: "$cryptoCurrency"+"graph",
                    child:
                      Image.asset(
                      'images/$cryptoCurrency.png',
                      height: 100.0,
                      width: 100.5,
                    ),
                  ),
                  SizedBox(height:20),
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: charts.TimeSeriesChart(
                        getData(cryptoCurrency), 
                        animate: true,
                        behaviors: [
                          charts.ChartTitle('Date',
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleStyleSpec: charts.TextStyleSpec(fontSize: 16),
                            titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea,),
                          charts.ChartTitle('Value',
                            behaviorPosition: charts.BehaviorPosition.start,
                            titleStyleSpec: charts.TextStyleSpec(fontSize: 16),
                            titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea,),
                          charts.ChartTitle('Price distribution for the past month',
                            behaviorPosition: charts.BehaviorPosition.top,
                            innerPadding: 40,
                            titleStyleSpec: charts.TextStyleSpec(fontSize: 16),),
                        ],
                        defaultRenderer: charts.LineRendererConfig(
                          includeArea: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: 380,
                  height: 300,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Now ' + openDaily + ' ' + cur,
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Change in past 24hr: ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(percentDaily+'%',
                            style: TextStyle(
                              fontSize: 18,
                              color: double.parse(percentDaily)>0? Colors.lightGreenAccent :Colors.red
                            ),
                          ),
                          percentDaily != '?'?
                          double.parse(percentDaily)>0 ?
                          Icon(Icons.arrow_drop_up, color: Colors.lightGreenAccent,): Icon(Icons.arrow_drop_down, color: Colors.red,):
                          Icon(null),

                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Change in the last Week: ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(percentWeekly+'%',
                            style: TextStyle(
                              fontSize: 18,
                              color: double.parse(percentWeekly)>0? Colors.lightGreenAccent :Colors.red
                            ),
                          ),
                          percentWeekly != '?'?
                          double.parse(percentWeekly)>0 ?
                          Icon(Icons.arrow_drop_up, color: Colors.lightGreenAccent,): Icon(Icons.arrow_drop_down, color: Colors.red,):
                          Icon(null),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Change in the last month: ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(percentMonthly+'%',
                            style: TextStyle(
                              fontSize: 18,
                              color: double.parse(percentMonthly)>0? Colors.lightGreenAccent :Colors.red
                            ),
                          ),
                          percentMonthly != '?'?
                          double.parse(percentMonthly)>0 ?
                          Icon(Icons.arrow_drop_up, color: Colors.lightGreenAccent,): Icon(Icons.arrow_drop_down, color: Colors.red,):
                          Icon(null),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('24hour Opening Price: ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(openDaily,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('High: ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(high,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                          Spacer(),
                          Text('Low: ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(low,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
  List<charts.Series<PlotData, DateTime>> getData(String cryptoCurrency){
    var data = cryptoCurrency == 'ETH'?ethgraphy : cryptoCurrency == 'BTC'?btcgraphy : ltcgraphy;
    print(cryptoCurrency);
    return [
        charts.Series<PlotData, DateTime>(
        id: '$cryptoCurrency Value',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (PlotData value, _) => value.date,
        measureFn: (PlotData value, _) => value.data,
        data: data,
        seriesColor: charts.Color.white,
      ),
    ];
  }
}