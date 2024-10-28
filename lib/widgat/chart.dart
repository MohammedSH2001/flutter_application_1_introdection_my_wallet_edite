import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/getdatahive.dart';
import 'package:flutter_application_1_introdection_my_wallet/shared/total.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  final int indexx;

  Chart({Key? key, required this.indexx}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Add_data>? a;

  @override
  Widget build(BuildContext context) {
    switch (widget.indexx) {
      case 0:
        a = today();
        break;
      case 1:
        a = week();
        break;
      case 2:
        a = month();
        break;
      case 3:
        a = year();
        break;
      default:
        a = [];
    }

    // تحقق من وجود بيانات قبل محاولة استخدامها
    if (a == null || a!.isEmpty) {
      return Center(child: Text('No data available'));
    }

    // تجميع البيانات حسب الفترات الزمنية
    Map<String, int> totals = {};
    DateTime now = DateTime.now();

    for (var entry in a!) {
      String key;

      if (widget.indexx == 0) { // اليوم
        key = '${entry.datatime.hour}:00';
      } else if (widget.indexx == 1) { // الأسبوع
        key = '${entry.datatime.year}-${entry.datatime.month}-${entry.datatime.day}';
      } else if (widget.indexx == 2) { // الشهر
        key = '${entry.datatime.year}-${entry.datatime.month}-${entry.datatime.day}';
      } else { // السنة
        key = '${entry.datatime.year}-${entry.datatime.month}'; // عرض الأشهر في السنة
      }

      // تحويل المبلغ إلى عدد صحيح
      int amount = int.tryParse(entry.amount) ?? 0;

      // إضافة المبلغ إلى الإجمالي اليومي
      totals.update(key, (value) => value + (entry.IN == 'Income' ? amount : -amount), ifAbsent: () => (entry.IN == 'Income' ? amount : -amount));
    }

    // تحويل البيانات المجمعة إلى قائمة
    List<SalesData> salesData = totals.entries.map((entry) {
      return SalesData(entry.key, entry.value);
    }).toList();

    return Container(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        title: ChartTitle(text: 'الإجمالي'),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(),
        series: <ColumnSeries<SalesData, String>>[
          ColumnSeries<SalesData, String>(
            color: Colors.blue, // لون افتراضي
            width: 0.1,
            dataSource: salesData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelMapper: (SalesData sales, _) => sales.sales.toString(),
            dataLabelSettings: DataLabelSettings(isVisible: true),
            borderRadius: BorderRadius.circular(30),
            // استخدام دالة لتغيير اللون بناءً على قيمة sales
            pointColorMapper: (SalesData sales, _) => sales.sales >= 0 ? Colors.green : Colors.red,
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year; // يمثل التاريخ أو الساعة أو الشهر
  final int sales; // يمثل إجمالي المبيعات
}