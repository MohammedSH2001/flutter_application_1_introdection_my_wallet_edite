import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Planning/Discounts.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Planning/NewsNow.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Planning/chat.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/introduction/SecondBoringScreen.dart';

class AddBalance extends StatefulWidget {
  const AddBalance({super.key});

  @override
  State<AddBalance> createState() => _AddBalanceState();
}

class _AddBalanceState extends State<AddBalance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
            
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Planning",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                  _buildCard(
                  context,
                  title: "Discounts",
                  image: "assets/discount.jpg",
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Discounts()));
                  },
                ),
                                SizedBox(height: 20),

                  _buildCard(
                  context,
                  title: "AI Chat",
                  image: "assets/chat.jpg",
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BotScreen()));
                  },
                ),
                SizedBox(height: 20,),
                _buildCard(
                  context,
                  title: "News",
                  image: "assets/news.jpg",
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NewsScreen()));
                  },
                ),
              
                SizedBox(height: 20),
                _buildCard(
                  context,
                  title: "Planning AI",
                  image: "assets/ai_2.jpg",
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SecondBoringScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required String title, required String image, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 340,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                image,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
