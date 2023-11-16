import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../data_models/historical_dividends_model.dart';


class HistoricalDividendsChartCard extends StatelessWidget {
  final HistoricalDividends dividends;

  HistoricalDividendsChartCard({required this.dividends});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        
        Expanded(
          child:  BarChart(


            BarChartData(


              titlesData: titlesData,
              borderData: borderData,
              barGroups: getBarGroups(dividends),
              gridData: const FlGridData(show: false),
              alignment: BarChartAlignment.start,



            ),
          ),
        )
        
      ],
    );
  }

  List<BarChartGroupData> getBarGroups(HistoricalDividends dividends) {
    List<BarChartGroupData> barGroups = [];

    if (dividends.items != null) {
      for (int i = 0; i < dividends.items!.length; i++) {
        Item dividend = dividends.items![i];
        barGroups.add(
          BarChartGroupData(
            x: i.toInt(),
            barRods: [
              BarChartRodData(
                borderRadius: BorderRadius.circular(2),
                toY: dividend.amountInEuro ?? 0,
                //gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [1], //was [0]
          ),
        );
      }
    }

    return barGroups;
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black38,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    if (value >= 0 && value < dividends.items!.length) {
      Item dividend = dividends.items![value.toInt()];
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10,
        child: Text( '${dividend.ticker}', style: style),
      );
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text('', style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(reservedSize: 40,showTitles: true),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  LinearGradient get _barsGradient => const LinearGradient(
    colors: [
      Colors.purple,
      Colors.greenAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}





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
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            Expanded(
              child: BarChart(

                BarChartData(
                  titlesData: titlesData,
                  borderData: borderData,
                  barGroups: getBarGroups(dividends),
                  gridData: const FlGridData(show: false),
                  alignment: BarChartAlignment.start,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> getBarGroups(HistoricalDividends dividends) {
    List<BarChartGroupData> barGroups = [];

    if (dividends.items != null) {
      for (int i = 0; i < dividends.items!.length; i++) {
        Item dividend = dividends.items![i];
        barGroups.add(
          BarChartGroupData(
            x: i.toInt(),
            barRods: [
              BarChartRodData(
                borderRadius: BorderRadius.circular(2),
                toY: dividend.amountInEuro ?? 0,
                //gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [1], //was [0]
          ),
        );
      }
    }

    return barGroups;
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black38,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    if (value >= 0 && value < dividends.items!.length) {
      Item dividend = dividends.items![value.toInt()];
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10,
        child: Text( '${dividend.ticker}', style: style),
      );
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text('', style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(reservedSize: 40,showTitles: true),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  LinearGradient get _barsGradient => const LinearGradient(
    colors: [
      Colors.purple,
      Colors.greenAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}


 */




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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Historical Dividends Chart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),)
                    ),
                    borderData: FlBorderData(//outer box of the plot
                      show: true,
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    gridData: const FlGridData(
                      show: true,

                      drawHorizontalLine: true,
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: getChartData(),
                        isCurved: true,
                        color: Colors.red,
                        dotData: const FlDotData(show: true, ),
                        show: true,
                        belowBarData: BarAreaData(show: false),
                        barWidth: 1,


                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<FlSpot> getChartData() {
    List<FlSpot> spots = [];

    if (dividends.items != null) {
      for (int i = 0; i < dividends.items!.length; i++) {
        Item dividend = dividends.items![i];
        // Use the amount as the Y-axis value and the date as the X-axis value

        spots.add(FlSpot( i.toDouble(),dividend.amountInEuro ?? 0));
      }
    }

    return spots;
  }
}


 */



