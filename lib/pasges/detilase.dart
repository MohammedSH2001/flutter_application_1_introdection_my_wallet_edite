import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/getdatahive.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/MyProfile.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/NotificationScreen.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Planning/chat.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/profile.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/total.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class TransactionDetailsPage extends StatefulWidget {
  final Add_data transaction;

  TransactionDetailsPage({Key? key, required this.transaction}) : super(key: key);

  @override
  State<TransactionDetailsPage> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  final userrr = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();

    // استماع للإشعارات الواردة عندما يكون التطبيق في المقدمة
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while app is in foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }

      // عرض إشعار أو رسالة تنبيه بناءً على البيانات الواردة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('New Notification: ${message.notification?.title}')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double incomePercent = (int.parse(widget.transaction.amount) / income()).clamp(0.0, 1.0);
    double expensesPercent = (expenses() / total()).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 2,
        title: Text(
          widget.transaction.name,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            onPressed: () {
              // إرسال الإشعار عند تحميل الصفحة
              // _sendNotification();
            },
            icon: Icon(Icons.notification_add_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Transaction Name: ${widget.transaction.name}',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  SizedBox(
                      height: 80,
                      width: 66,
                      child: Image.asset('assets/${widget.transaction.name}.png'))
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Type: ${widget.transaction.IN}',
                style: TextStyle(
                  fontSize: 22,
                  color: widget.transaction.IN == 'Income'
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Explain: ${widget.transaction.explain}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Amount: \$${widget.transaction.amount}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Date: ${widget.transaction.datatime}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Center(
                child: CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 12.0,
                  percent: incomePercent.clamp(0.0, 1.0),
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.transaction.IN == 'Income'
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: widget.transaction.IN == 'Income'
                            ? Colors.green
                            : Colors.red,
                        size: 50,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${(incomePercent * 100).toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: widget.transaction.IN == 'Income'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  progressColor: widget.transaction.IN == 'Income'
                      ? Colors.green
                      : Colors.red,
                  backgroundColor: const Color.fromARGB(255, 235, 230, 230),
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 800,
                ),
              ),
              SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(
                  text: 'Transactions Overview',
                ),
                series: <CartesianSeries>[
                  ColumnSeries<TransactionData, String>(
                    dataSource: getTransactionData(),
                    xValueMapper: (TransactionData transaction, _) =>
                        transaction.type,
                    yValueMapper: (TransactionData transaction, _) =>
                        transaction.count,
                    pointColorMapper: (TransactionData transaction, _) {
                      if (transaction.type == 'Income') {
                        return Colors.green;
                      } else if (transaction.type == 'Expense') {
                        return Colors.red;
                      } else {
                        return Colors.yellow;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _sendNotification() async {
  //   String? token = await getToken(); 

  //   if (token != null) {
  //     print("Doneeeee");
  //     await NotificationScreen.sendNotification(
  //       token,
  //       'تفاصيل المعاملة',
  //       'لقد فتحت تفاصيل المعاملة ${widget.transaction.name}',
  //     );
  //     appMessage(text: 'Doneee', fail: false, context: context);
  //     print("Token => $token");
  //     print("Notification sent successfully.");
  //   } else {
  //     print("Failed to get device token.");
  //   }
  // }
}

List<TransactionData> getTransactionData() {
  return [
    TransactionData(
      'Income',
      countIncome().toDouble(),
    ),
    TransactionData(
      'Expense',
      ((countTotalTransactions().toDouble() - countIncome().toDouble())),
    ),
    TransactionData('Total', countTotalTransactions().toDouble()),
  ];
}

class TransactionData {
  final String type;
  final double count;

  TransactionData(this.type, this.count);
}

FirebaseMessaging deviceToken = FirebaseMessaging.instance;

Future<String?> getToken() async {
  String? token = await deviceToken.getToken();
  print("Token => $token");
  return token!;
}

void appMessage({required String text, required bool fail, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}
