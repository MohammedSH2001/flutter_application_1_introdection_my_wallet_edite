import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/Data_from_firestore.dart';

class Myprofile extends StatefulWidget {
  const Myprofile({super.key});

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  final userrr = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            "Account",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                height: 70,
                width: 100,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(44,),color: Colors.black12,
                  ),
                child: Image.asset(
                  "assets/ava.png",
                  width: 70,
                  height: 97,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetDataFromFirestore(documentId: userrr.uid),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
