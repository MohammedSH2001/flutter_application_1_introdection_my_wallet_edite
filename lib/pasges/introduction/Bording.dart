import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/introduction/ButtomSection.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/introduction/FirstBordingScreen.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/introduction/SecondBoringScreen.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/introduction/ThirdBordingScreen.dart';

class BordingScreen extends StatefulWidget {
  const BordingScreen({super.key});

  @override
  State<BordingScreen> createState() => _BordingScreenState();
}

class _BordingScreenState extends State<BordingScreen> {
  PageController myController = PageController();
  int currentPage = 0; // استخدم currentPage بدلاً من isLastScreen

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: myController,
          children: [
            FirstBordingScreen(),
            SecondBoringScreen(),
            Thirdbordingscreen(),
          ],
          onPageChanged: (page) {
            setState(() {
              currentPage = page; // تحديث currentPage
            });
          },
        ),
        ButtomSectionMy(
          controller: myController,
          currentPage: currentPage, // تمرير currentPage هنا
        ),
      ],
    );
  }
}