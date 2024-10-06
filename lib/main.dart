import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Dashbord.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Staicastic.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/profile.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/Bottun.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
  
}
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: BottunMy(),
    );
  }
}