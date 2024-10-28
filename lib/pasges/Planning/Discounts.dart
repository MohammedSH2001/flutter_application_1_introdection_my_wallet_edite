import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Planning/Shop.dart/MunirShop.dart';
import 'package:flutter_application_1_introdection_my_wallet/shared/settingitem.dart';
import 'package:ionicons/ionicons.dart';

class Discounts extends StatefulWidget {
  const Discounts({super.key});

  @override
  State<Discounts> createState() => _DiscountsState();
}

class _DiscountsState extends State<Discounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shops",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    settingitem(
                      title: "سوق منير",
                      icon: Ionicons.earth_outline,
                      bgColor: Colors.orange.shade100,
                      iconsColor: Colors.orange,
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MunirShop()));
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    settingitem(
                      title: "سوق النعيري",
                      icon: Ionicons.earth_outline,
                      bgColor: const Color.fromARGB(255, 209, 255, 178),
                      iconsColor: Colors.green,
                      ontap: () {},
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    settingitem(
                      title: "توم سنتر",
                      icon: Ionicons.earth_outline,
                      bgColor: const Color.fromARGB(144, 178, 191, 255),
                      iconsColor: Colors.blue,
                      ontap: () {},
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
