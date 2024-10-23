// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/auth/login.dart';
import 'package:flutter_application_1_introdection_my_wallet/shared/color.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/consts.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/snackbar.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // File? imgPath;

  final _formKey = GlobalKey<FormState>();
  final usernameContriller = TextEditingController();
  final passowrdContriller = TextEditingController();
  final emailContriller = TextEditingController();
  final ageContriller = TextEditingController();
  final titleContriller = TextEditingController();

  bool isPassowrdchar = false;
  bool isNumber = false;
  bool isUpercase = false;
  bool isLowercase = false;
  bool isSpcialCharacters = false;

  // uploadImage() async {
  //   final pickedImg = await ImagePicker().pickImage(source: ImageSource.camera);
  //   try {
  //     if (pickedImg != null) {
  //       setState(() {
  //         imgPath = File(pickedImg.path);
  //       });
  //     } else {
  //       print("NO img selected");
  //     }
  //   } catch (e) {
  //     print("Error => $e");
  //   }
  // }

  isSpcialToken(String password) {
    isSpcialCharacters = false;
    setState(() {
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        isSpcialCharacters = true;
      }
    });
  }

  isLowerCase(String password) {
    isLowercase = false;
    setState(() {
      if (password.contains(RegExp(r'[a-z]'))) {
        isLowercase = true;
      }
    });
  }

  isUpowerCase(String password) {
    isUpercase = false;
    setState(() {
      if (password.contains(RegExp(r'[A-Z]'))) {
        isUpercase = true;
      }
    });
  }

  onnumber(String password) {
    isNumber = false;
    setState(() {
      if (password.contains(RegExp(r'[0-9]'))) {
        isNumber = true;
      }
    });
  }

  onpasswordchange(String password) {
    isPassowrdchar = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassowrdchar = true;
      }
    });
  }

  bool isLoading = false;
  bool isvisibality = true;

  register() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailContriller.text,
        password: passowrdContriller.text,
      );

      CollectionReference users = FirebaseFirestore.instance.collection('USERSSS');

      users
          .doc(credential.user?.uid)
          .set({
            'username': usernameContriller.text,
            'age': ageContriller.text,
            'title': titleContriller.text,
            'email': emailContriller.text,
            'password': passowrdContriller.text
          })
          // ignore: avoid_print
          .then((value) => print("User Added"))
          // ignore: avoid_print
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.");
      } else {
        showSnackBar(context, "ERROR - Please try again late");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   emailContriller.dispose();
  //   passowrdContriller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Padding(
          padding: const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(children: [
                    // CircleAvatar(
                    //   backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                    //   radius: 65,
                    //   backgroundImage: AssetImage('assets/img/avatar_2.png'),
                    // ),
                    // Positioned(
                    //     bottom: -13,
                    //     left: 90,
                    //     child: IconButton(
                    //         onPressed: () {
                    //           // uploadImage();
                    //         },
                    //         icon: Icon(Icons.add_a_photo))),
                  ]),
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      controller: usernameContriller,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your username : ",
                          suffixIcon: Icon(Icons.person))),
                  const SizedBox(
                    height: 33,
                  ),
                  TextField(
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      controller: ageContriller,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your Age : ",
                          suffixIcon: Icon(Icons.pest_control_rodent))),
                  const SizedBox(
                    height: 33,
                  ),
                  TextField(
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      controller: titleContriller,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your title : ",
                          suffixIcon: Icon(Icons.person_2_outlined))),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                    validator: (email) {
                      return email!.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                          ? null
                          : "Enter a valid email";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailContriller,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your Email : ",
                        suffixIcon: Icon(Icons.email)),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                      onChanged: (password) {
                        onpasswordchange(password);
                        onnumber(password);
                        isUpowerCase(password);
                        isLowerCase(password);
                        isSpcialToken(password);
                      },
                      validator: (value) {
                        return value!.length < 8
                            ? "Enter at least 8 characters"
                            : null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passowrdContriller,
                      keyboardType: TextInputType.text,
                      obscureText: isvisibality ? true : false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your Password : ",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isvisibality = !isvisibality;
                                });
                              },
                              icon: isvisibality
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)))),
                  const SizedBox(
                    height: 33,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPassowrdchar ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("At least 8 characters")
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isNumber ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("At least 1 number")
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isUpercase ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("Has Upercase")
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isLowercase ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("Has Lowercase")
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSpcialCharacters
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("Has Spcial Characters")
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //يتحقق من حقول الادخال كلها
                      if (_formKey.currentState!.validate()) {
                        await register();
                        if (!mounted) return;
                        {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login_auth()));
                        }
                      } else {
                        showSnackBar(context, "ERROR");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNgreen),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Register",
                            style: TextStyle(fontSize: 19, color: Colors.white),
                          ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
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
                                  builder: (context) => Login_auth()));
                        },
                        child: Text('sign in',
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
