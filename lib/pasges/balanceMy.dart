import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Dashbord.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/Bottun.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBalance extends StatefulWidget {
  const AddBalance({super.key});

  @override
  State<AddBalance> createState() => _AddBalanceState();
}

class _AddBalanceState extends State<AddBalance> {
  SharedPreferencesAsync pref = SharedPreferencesAsync();
  int addbalanceMy =0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            keyboardType: TextInputType.number,
            onSubmitted: (addMybalance) async {
            
              await pref.setInt("AddBalance", int.parse(addMybalance));
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.person),
              hintText: "AddBalance",
            ),
          ),
          ElevatedButton(
            onPressed: ()async {
               addbalanceMy = await pref.getInt("AddBalance") ?? 0;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottunMy(
                                    
                                  
                                  )));
            },
            child: Text(
              "AddBalance",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 27, 42, 154)),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 95, vertical: 10)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
