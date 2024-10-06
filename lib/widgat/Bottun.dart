import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Dashbord.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Staicastic.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/addscreen.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/balanceMy.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/profile.dart';

class BottunMy extends StatefulWidget {
  const BottunMy({super.key});

  @override
  State<BottunMy> createState() => _BottunMyState();
}

class _BottunMyState extends State<BottunMy> {
  int indx_color = 0;
  List Screen = [Dashbord(AddBalance: 0,), Statistics(), AddBalance(), Account()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[indx_color],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddScreenMy()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 3, 32, 149),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
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
                  Icons.home,
                  size: 30,
                  color: indx_color == 0
                      ? Color.fromARGB(255, 3, 32, 149)
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
                  Icons.bar_chart_outlined,
                  size: 30,
                  color: indx_color == 1
                      ? Color.fromARGB(255, 3, 32, 149)
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
                  Icons.account_balance_outlined,
                  size: 30,
                  color: indx_color == 2
                      ? Color.fromARGB(255, 3, 32, 149)
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
                  Icons.person_2_outlined,
                  size: 30,
                  color: indx_color == 3
                      ? Color.fromARGB(255, 3, 32, 149)
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
