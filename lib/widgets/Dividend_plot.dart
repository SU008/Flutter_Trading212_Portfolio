import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../data_models/historical_dividends_model.dart';
/*
class HistoricalDividendsChartCard extends StatelessWidget {
  final HistoricalDividends dividends;

  HistoricalDividendsChartCard({required this.dividends});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.blue[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Historical Dividends Chart',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: true),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        // Format the X-axis labels (amount paid)
                        return '\$${value.toStringAsFixed(2)}';
                      },
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: getChartData(),
                      isCurved: true,
                      color: [Colors.blue],
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> getChartData() {
    List<FlSpot> spots = [];

    if (dividends.items != null) {
      for (int i = 0; i < dividends.items!.length; i++) {
        Item dividend = dividends.items![i];
        // Use the amount as the X-axis value and the date as the Y-axis value
        spots.add(FlSpot(dividend.amountInEuro ?? 0, i.toDouble()));
      }
    }

    return spots;
  }
}


 */