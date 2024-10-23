import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/MyProfile.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/auth/login.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/forwerbutton.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/settingitem.dart';
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
    return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.chevron_left_outlined,size: 36,),
          // ),
          // leadingWidth: 75,
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Setting",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/ava.png",
                      width: 40,
                      height: 50,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isLoading
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator())
                            : Text(
                                username,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                    Spacer(),
                    forwerButton(
                      onTap: () {
                          Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Myprofile()));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Setting",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              settingitem(
                title: "Language",
                icon: Ionicons.earth_outline,
                bgColor: Colors.orange.shade100,
                iconsColor: Colors.orange,
                value: "English",
                ontap: () {},
              ),
              SizedBox(
                height: 20,
              ),
              settingitem(
                title: "Natifications",
                icon: Ionicons.notifications_outline,
                bgColor: Colors.green.shade100,
                iconsColor: Colors.green,
                ontap: () {},
              ),
              SizedBox(
                height: 20,
              ),
              settingitem(
                title: "Dark Mode",
                icon: Ionicons.earth,
                bgColor: Colors.red.shade100,
                iconsColor: Colors.red,
                ontap: (){
                        // Provider.of<ThemeProvider>(context , listen:false).toggleTheme();
                },
              ),
              SizedBox(
                height: 20,
              ),
              settingitem(
                title: "Help",
                icon: Ionicons.nuclear_outline,
                bgColor: Colors.purple.shade100,
                iconsColor: Colors.purple,
                ontap: () {},
              ),
              SizedBox(height: 20,),
              settingitem(
                title: "Log out",
                icon: Ionicons.log_out_outline,
                bgColor: Colors.red.shade100,
                iconsColor: const Color.fromARGB(255, 255, 0, 0),
                ontap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login_auth()));
                    },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
