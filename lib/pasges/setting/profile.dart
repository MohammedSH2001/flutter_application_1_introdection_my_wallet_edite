import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/setting/Account/MyProfile.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/auth/login.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/forwerbutton.dart';
import 'package:flutter_application_1_introdection_my_wallet/shared/settingitem.dart';
import 'package:ionicons/ionicons.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final userrr = FirebaseAuth.instance.currentUser!;
  String title = "Loading...";
  String username = "Loading...";
  bool isLoading = true;

  Future<void> fetchTitle() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('USERSSS')
          .doc(userrr.uid)
          .get();

      setState(() {
        title = documentSnapshot.get('title');
        username = documentSnapshot.get('username');
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        title = "Error loading ";
      });
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Setting",
                style: TextStyle(
                  fontSize: screenWidth * 0.09,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      "assets/ava.png",
                      width: screenWidth * 0.12,
                      height: screenHeight * 0.08,
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isLoading
                            ? SizedBox(
                                height: screenWidth * 0.06,
                                width: screenWidth * 0.06,
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                username,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    forwerButton(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Myprofile(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Text(
                "Setting",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              settingitem(
                title: "Language",
                icon: Ionicons.earth_outline,
                bgColor: Colors.orange.shade100,
                iconsColor: Colors.orange,
                value: "English",
                ontap: () {},
              ),
              SizedBox(height: screenHeight * 0.02),
              settingitem(
                title: "Notifications",
                icon: Ionicons.notifications_outline,
                bgColor: Colors.green.shade100,
                iconsColor: Colors.green,
                ontap: () {},
              ),
              SizedBox(height: screenHeight * 0.02),
              settingitem(
                title: "Dark Mode",
                icon: Ionicons.earth,
                bgColor: Colors.red.shade100,
                iconsColor: Colors.red,
                ontap: () {},
              ),
              SizedBox(height: screenHeight * 0.02),
              settingitem(
                title: "Help",
                icon: Ionicons.nuclear_outline,
                bgColor: Colors.purple.shade100,
                iconsColor: Colors.purple,
                ontap: () {},
              ),
              SizedBox(height: screenHeight * 0.02),
              settingitem(
                title: "Log out",
                icon: Ionicons.log_out_outline,
                bgColor: Colors.red.shade100,
                iconsColor: Colors.red,
                ontap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login_auth(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
