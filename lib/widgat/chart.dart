import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart_my extends StatefulWidget {
  const Chart_my({super.key});

  @override
  State<Chart_my> createState() => _Chart_myState();
}

class _Chart_myState extends State<Chart_my> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <SplineSeries<SalesData, String>>[
          SplineSeries<SalesData, String>(
            color: Color.fromARGB(255, 3, 32, 149),
            width: 4,
            dataSource: <SalesData>[
              SalesData(100, 'mon'),
              SalesData(200, 'Tue'),
              SalesData(40, 'Wen'),
              SalesData(15, 'mon'),
              SalesData(5, 'sun'),
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
          ),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.sales, this.year);
  final String year;
  final int sales;
}
