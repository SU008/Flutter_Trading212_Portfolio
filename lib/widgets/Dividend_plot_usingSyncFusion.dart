
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../data_models/historical_dividends_model.dart';


import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HistoricalDividendsChartCard2 extends StatelessWidget {
  final HistoricalDividends dividends;

  HistoricalDividendsChartCard2({required this.dividends});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Historical Dividends Chart',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: Expanded(

              child: Transform.rotate(
                angle:0,//-1.5708, //90 degrees
                child: SfCartesianChart(

                  primaryXAxis: NumericAxis(
                    zoomFactor: 0.5, // Adjust the zoom factor as needed
                    zoomPosition: 0.5, // Adjust the zoom position as needed
                    interval: 5, // Set the interval to control space between data points
                  ),


                  primaryYAxis: NumericAxis(
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                    labelPosition: ChartDataLabelPosition.outside,

                    majorGridLines: MajorGridLines(width: 0),
                    majorTickLines: MajorTickLines(size: 0),
                    minorTickLines: MinorTickLines(size: 0),


                  ),





                  //primaryXAxis: NumericAxis(),
                  //primaryYAxis: NumericAxis(),

                  series: <ChartSeries>[
                    BarSeries<Item, int>(
                      dataLabelSettings: const DataLabelSettings(isVisible: true),

                      dataSource: dividends.items ?? [],

                      xValueMapper: (Item item, _) => dividends.items!.indexOf(item),
                      yValueMapper: (Item item, _) => item.amountInEuro ?? 0,
                      borderRadius: BorderRadius.circular(2),
                      //gradient: _barsGradient,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}