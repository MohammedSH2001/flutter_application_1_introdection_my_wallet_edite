import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/auth/login.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ButtomSectionMy extends StatefulWidget {
  final PageController controller;
  final int currentPage;
  const ButtomSectionMy({
    super.key,
    required this.controller,
    required this.currentPage,
  });

  @override
  State<ButtomSectionMy> createState() => _ButtomSectionMyState();
}

class _ButtomSectionMyState extends State<ButtomSectionMy> {
  @override
  Widget build(BuildContext context) {
    double percent = (widget.currentPage + 1) / 3;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SmoothPageIndicator(controller: widget.controller, count: 3),
          SizedBox(height: 10),

          CircularPercentIndicator(
            radius: 40,
            animation: true,
            animationDuration: 700,
            percent: percent,
            animateFromLastPercent: true,
            progressColor: Colors.blue,
            center: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  if (widget.currentPage == 2) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login_auth()),
                    );
                  } else {
                    widget.controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                icon: Icon(
                  widget.currentPage == 2
                      ? Icons.check
                      : Icons.keyboard_arrow_right,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          widget.currentPage == 2
              ? const SizedBox(
            height: 19,
          )
              : GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login_auth()),
            ),
            child: const Text(
              "Skip",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}