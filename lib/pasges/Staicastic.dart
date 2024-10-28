import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/getdatahive.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/chart.dart';
import 'package:flutter_application_1_introdection_my_wallet/shared/total.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

ValueNotifier<int> kj = ValueNotifier(0);

class _StatisticsState extends State<Statistics> {
  List<String> day = ['Day', 'Week', 'Month', 'Year'];
  List<List<Add_data>> f = [today(), week(), month(), year()];
  List<Add_data> a = [];
  int index_color = 0;

  @override
  void initState() {
    super.initState();
    kj.addListener(_updateData);
  }

  void _updateData() {
    // تحقق من خاصية mounted
    if (mounted) {
      setState(() {
        a = f[kj.value];
      });
    }
  }

  @override
  void dispose() {
    // إلغاء الاشتراك في المستمعات
    kj.removeListener(_updateData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: ValueListenableBuilder<int>(
          valueListenable: kj,
          builder: (BuildContext context, value, Widget? child) {
            a = f[value]; // قم بتحديث 'a' هنا
            return custom();
          },
        ),
      ),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Statistics',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      day.length,
                      (index) {
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // تحقق من خاصية mounted قبل استدعاء setState
                              if (mounted) {
                                setState(() {
                                  index_color = index;
                                  kj.value = index;
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index_color == index
                                    ? Color.fromARGB(255, 23, 107, 135)
                                    : Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                day[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: index_color == index
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Chart(indexx: index_color),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Spending',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.swap_vert, size: 25, color: Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index >= a.length) return SizedBox(); // Prevent out of bounds
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/${a[index].name}.png',
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 40,
                        width: 40,
                        color: Colors.grey, // Placeholder color
                      );
                    },
                  ),
                ),
                title: Text(
                  a[index].name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '${a[index].datatime.year}-${a[index].datatime.day}-${a[index].datatime.month}',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: Text(
                  a[index].amount,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: a[index].IN == 'Income' ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
            childCount: a.length,
          ),
        ),
      ],
    );
  }
}