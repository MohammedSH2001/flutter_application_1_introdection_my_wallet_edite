import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalysisScreen extends StatelessWidget {
  final Map<String, double> analysis;

  const AnalysisScreen({Key? key, required this.analysis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تحليل البيانات"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "تحليل النفقات",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    height: 300,
                    padding: const EdgeInsets.all(16.0),
                    child: buildChart(analysis),
                  ),
                ),
                const SizedBox(height: 20),
                buildAdvice(analysis),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChart(Map<String, double> analysis) {
    List<Color> colors = [
      Colors.teal,
      Colors.blue,
      Colors.orange,
      Colors.red,
      Colors.green,
      Colors.purple,
    ];

    return PieChart(
      PieChartData(
        sections: analysis.entries.toList().asMap().entries.map((entry) {
          int index = entry.key;
          MapEntry<String, double> category = entry.value;

          return PieChartSectionData(
            value: category.value,
            title: category.key,
            color: colors[index % colors.length],
            radius: 60,
            titleStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildAdvice(Map<String, double> analysis) {
    List<String> advice = [];

    analysis.forEach((category, amount) {
      bool isAddition = amount > 0;

      if (isAddition) {
        advice.add("🌟 رائع! لديك نفقات إيجابية في '$category'. استمر في ذلك!");
      } else if (amount > 1000) {
        advice.add("⚠️ حذر! النفقات في '$category' مرتفعة جدًا.");
      } else if (amount > 500) {
        advice.add("🔍 تأكد من مراقبة نفقات '$category'.");
      } else {
        advice.add("👍 جيد جدًا! نفقات '$category' تحت السيطرة.");
      }
    });

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.teal.shade50, // خلفية للصندوق
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "نصائح:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 10),
            ...advice.map((tip) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    tip,
                    style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500), // تخصيص الخط
                  ),
                )),
          ],
        ),
      ),
    );
  }
}