import 'package:flutter/material.dart';

class SecondBoringScreen extends StatefulWidget {
  const SecondBoringScreen({super.key});

  @override
  State<SecondBoringScreen> createState() => _SecondBoringScreenState();
}

class _SecondBoringScreenState extends State<SecondBoringScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/track_your_spending.png", width: 200, height: 200),
                SizedBox(height: 20),
                Text(
                  "Track your Spending",
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