import 'package:flutter/material.dart';

class FirstBordingScreen extends StatefulWidget {
  const FirstBordingScreen({super.key});

  @override
  State<FirstBordingScreen> createState() => _FirstBordingScreenState();
}

class _FirstBordingScreenState extends State<FirstBordingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/wallet.png", width: 200, height: 200),
                SizedBox(height: 20),
                Text(
                  "Hello!",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome to Wallet, the best way to get financial freedom.",
                  style: TextStyle(fontSize: 20, color: Colors.white),
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
