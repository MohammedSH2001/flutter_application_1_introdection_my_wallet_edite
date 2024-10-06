import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/forwerbutton.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/settingitem.dart';
import 'package:ionicons/ionicons.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              Row(
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
                      Text(
                        "Mohammed ALShwaish",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Devoleper App",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  Spacer(),
                  forwerButton(onTap: (){},),
                ],
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
                icon: Ionicons.earth,
                bgColor: Colors.orange.shade100,
                iconsColor: Colors.orange,
                value: "English",
                ontap: (){},
              ),
              SizedBox(height: 20,),
              settingitem(
                title: "Natifications",
                icon: Ionicons.earth,
                bgColor: Colors.blue.shade100,
                iconsColor: Colors.blue,
                ontap: (){},
              ),
              SizedBox(height: 20,),
              settingitem(
                title: "Dark Mode",
                icon: Ionicons.earth,
                bgColor: Colors.red.shade100,
                iconsColor: Colors.red,
                ontap: (){},
              ),
              SizedBox(height: 20,),
              settingitem(
                title: "Help",
                icon: Ionicons.nuclear,
                bgColor: Colors.purple.shade100,
                iconsColor: Colors.purple,
                ontap: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
