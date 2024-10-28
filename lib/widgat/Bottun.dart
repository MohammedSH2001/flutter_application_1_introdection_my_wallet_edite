import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Dashbord.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Staicastic.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/addscreen.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/balanceMy.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/setting/profile.dart';
import 'package:ionicons/ionicons.dart';

class BottunMy extends StatefulWidget {
  const BottunMy({
    super.key,
  });

  @override
  State<BottunMy> createState() => _BottunMyState();
}

class _BottunMyState extends State<BottunMy> {
  int indx_color = 0;
  List Screen = [Dashbord(), Statistics(), AddBalance(), Account()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[indx_color],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddScreenMy()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 23, 107, 135),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        color: Colors.grey.shade200,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    indx_color = 0;
                  });
                },
                child: Icon(
                  Ionicons.home_sharp,
                  size: 30,
                  color: indx_color == 0
                      ? Color.fromARGB(255, 23, 107, 135)
                      : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    indx_color = 1;
                  });
                },
                child: Icon(
                  Ionicons.bar_chart,
                  size: 30,
                  color: indx_color == 1
                      ? Color.fromARGB(255, 23, 107, 135)
                      : Colors.grey,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    indx_color = 2;
                  });
                },
                child: Icon(
                  Icons.account_balance,
                  size: 30,
                  color: indx_color == 2
                      ? Color.fromARGB(255, 23, 107, 135)
                      : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    indx_color = 3;
                  });
                },
                child: Icon(
                  Icons.person,
                  size: 35,
                  color: indx_color == 3
                      ? Color.fromARGB(255, 23, 107, 135)
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
