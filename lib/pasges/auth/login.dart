
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/auth/signup.dart';
import 'package:flutter_application_1_introdection_my_wallet/shared/color.dart';
import 'package:flutter_application_1_introdection_my_wallet/shared/textFieldProper.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/Bottun.dart';
import 'package:flutter_application_1_introdection_my_wallet/shared/consts.dart';
import 'package:flutter_application_1_introdection_my_wallet/shared/snackbar.dart';

class Login_auth extends StatefulWidget {
  Login_auth({super.key});

  @override
  State<Login_auth> createState() => _LoginState();
}

class _LoginState extends State<Login_auth> {
  final emailContriller = TextEditingController();
  final passowrdContriller = TextEditingController();
  bool isvizibility = true;

  signIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailContriller.text, password: passowrdContriller.text);

      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottunMy()));
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR - ${e.code}");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailContriller.dispose();
    passowrdContriller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  width: 350,
                  height: 300,
                  child: Image.asset('assets/logNew.png'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: emailContriller,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: decorationTextfield.copyWith(
                    hintText: "Enter Your Email  ",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.email),
                    ),
                    border: CustomBorders.defaultBorder(),
                    focusedBorder: CustomBorders.focusedBorder(),
                    enabledBorder: CustomBorders.enabledBorder(),
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                TextField(
                  controller: passowrdContriller,
                  keyboardType: TextInputType.text,
                  obscureText: isvizibility ? true : false,
                  decoration: decorationTextfield.copyWith(
                    border:CustomBorders.defaultBorder(),
                    focusedBorder: CustomBorders.focusedBorder(),
                    enabledBorder:CustomBorders.enabledBorder(),
                    hintText: "Enter Your Password  ",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isvizibility = !isvizibility;
                        });
                      },
                      icon: isvizibility
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [Colors.greenAccent, BTNgreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      await signIn();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextButton(
                    onPressed: () {
                      // navigate(context);
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.purple.shade900),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do not have acconut?",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text('sign up',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 17,
                              color: Colors.purple.shade900)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// void navigate(BuildContext x) {
//   Navigator.push(x, MaterialPageRoute(builder: (context) => Register()));
// }
