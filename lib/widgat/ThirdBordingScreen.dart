import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Thirdbordingscreen extends StatefulWidget {
  const Thirdbordingscreen({super.key});

  @override
  State<Thirdbordingscreen> createState() => _ThirdbordingscreenState();
}

class _ThirdbordingscreenState extends State<Thirdbordingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/budget_your_money.png", width: 200, height: 200),
                SizedBox(height: 20),
                Text(
                  "Budget your money",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome to Wallet, the best way to get financial freedom.",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
