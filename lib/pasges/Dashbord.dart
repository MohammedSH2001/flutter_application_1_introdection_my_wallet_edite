import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/getdatahive.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/All_data_to_firestore.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/EditeTransaction.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Planning/devPlanning.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/detilase.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/getDataMy.dart';
import 'package:flutter_application_1_introdection_my_wallet/shared/total.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({Key? key}) : super(key: key);

  @override
  State<Dashbord> createState() => _HomeState();
}

class TransactionData {
  final String type;
  final double count;

  TransactionData(this.type, this.count);
}

class _HomeState extends State<Dashbord> {
  final credential = FirebaseAuth.instance.currentUser;
  final userrr = FirebaseAuth.instance.currentUser!;
  String username = "Loading...";
  bool isLoading = true;

  Future<void> fetchTitle() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('USERSSS')
          .doc(userrr.uid)
          .get();

      if (mounted) { 
        setState(() {
          username = documentSnapshot.get('username');
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) { 
        setState(() {
          username = "Error loading ";
        });
      }
    }
}


  @override
  void initState() {
    fetchTitle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, value, child) {
            Map<DateTime, List<Add_data>> transactionsByDate = {};
            for (var transaction in box.values) {
              DateTime date = DateTime(transaction.datatime.year,
                  transaction.datatime.month, transaction.datatime.day);
              if (transactionsByDate[date] == null) {
                transactionsByDate[date] = [];
              }
              transactionsByDate[date]!.add(transaction);
            }

            DateTime today = DateTime.now();
            List<DateTime> sortedDates = transactionsByDate.keys.toList()
              ..sort((a, b) {
                if (a.year == today.year &&
                    a.month == today.month &&
                    a.day == today.day) {
                  return -1;
                } else if (b.year == today.year &&
                    b.month == today.month &&
                    b.day == today.day) {
                  return 1;
                }
                return b.compareTo(a);
              });

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 390,
                    child: _head(screenWidth),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transactions History',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                          ),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      DateTime date = sortedDates[index];
                      List<Add_data> transactions = transactionsByDate[date]!;

                      List<Add_data> displayedTransactions =
                          transactions.take(3).toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                            child: Text(
                              '${date.year}-${date.month}-${date.day}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          ...displayedTransactions
                              .map((transaction) => getList(transaction))
                              .toList(),
                          if (transactions.length > 3)
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('More Transactions', style: TextStyle(color: const Color.fromARGB(255, 44, 39, 176)),),
                                    content: SizedBox(
                                      height: 300,
                                      width: 300,
                                      child: ListView.builder(
                                        itemCount: transactions.length,
                                        itemBuilder: (context, index) {
                                          return getList(transactions[index]);
                                        },
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text(
                                'Show more (${transactions.length - 3})', 
                                style: TextStyle(color: const Color.fromARGB(186, 113, 77, 255)),
                              ),
                            ),
                        ],
                      );
                    },
                    childCount: sortedDates.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getList(Add_data history) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        history.delete();
      },
      background: Container(
        color: const Color.fromARGB(255, 246, 52, 38),
        child: Icon(
          Icons.cancel,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionDetailsPage(transaction: history),
            ),
          );
        },
        child: Card(
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/${history.name}.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        history.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${getDay(history.datatime.weekday)}  ${history.datatime.year}-${history.datatime.month}-${history.datatime.day}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      history.amount,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: history.IN == 'Income' ? Colors.green : Colors.red,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTransactionPage(transaction: history),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget _head(double screenWidth) {
  return Stack(
    children: [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: SizedBox(
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getGreetingMessage(),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                            Padding(
            padding: const EdgeInsets.only( right: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FetchDataScreen()));
                },
                icon: Icon(
                  Icons.notifications_outlined,
                  size: 30,
                ),
              ),
            ),
          ),
                    ],
                  ),
            
                ],
              ),
            ),
          ),
          
        ],
      ),
      Positioned(
        
        top: 105,
        left: 15,
        right: 15,
        child: Container(
          height: 173,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(200, 25, 37, 103),
                offset: Offset(0, 3),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 23, 107, 135),
                Color.fromARGB(255, 80, 204, 197)
              ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        try {
                          await syncData();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Data uploaded successfully!')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Failed to upload data: $e')),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.refresh,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Total Balance',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyAppPlanning()));
                      },
                      icon: Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$ ${total()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: Color.fromARGB(100, 238, 238, 238),
                          child: Icon(
                            Icons.arrow_downward_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 7),
                        Text(
                          'Income',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color.fromARGB(255, 216, 216, 216),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: Color.fromARGB(100, 238, 238, 238),
                          child: Icon(
                            Icons.arrow_upward_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 7),
                        Text(
                          'Expenses',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color.fromARGB(255, 216, 216, 216),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${income()}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '\$ ${expenses()}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: 300,
        left: 50,
        child: CircularPercentIndicator(
          radius: 33.0,
          lineWidth: 7.0,
          percent: total().toDouble().clamp(0.0, 1.0),
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(total().toDouble()).toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          progressColor: Colors.amber,
          backgroundColor: const Color.fromARGB(255, 235, 230, 230),
          circularStrokeCap: CircularStrokeCap.round,
          animation: true,
          animateFromLastPercent: true,
          animationDuration: 800,
        ),
      ),
      Positioned(
        top: 300,
        left: 170,
        child: CircularPercentIndicator(
          radius: 33.0,
          lineWidth: 7.0,
          percent: (income() % 1.5).toDouble().clamp(0.0, 1.0),
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(income().toDouble()).toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          progressColor: Colors.green,
          backgroundColor: const Color.fromARGB(255, 235, 230, 230),
          circularStrokeCap: CircularStrokeCap.round,
          animation: true,
          animateFromLastPercent: true,
          animationDuration: 800,
        ),
      ),
      Positioned(
        top: 300,
        right: 50,
        child: CircularPercentIndicator(
          radius: 33.0,
          lineWidth: 7.0,
          percent: ((expenses() * -1) % 1.199).toDouble().clamp(0.0, 1.0),
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${((expenses().toDouble() * -1)).toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          progressColor: Colors.red,
          backgroundColor: const Color.fromARGB(255, 235, 230, 230),
          circularStrokeCap: CircularStrokeCap.round,
          animation: true,
          animateFromLastPercent: true,
          animationDuration: 800,
        ),
      ),
    ],
  );
}

  String getGreetingMessage() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  String getDay(int weekday) {
    const days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    return days[weekday - 1];
  }
}