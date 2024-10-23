// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

const decorationTextfield = InputDecoration(
  // hintText: "Enter Your Email : ",
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromARGB(255, 157, 155, 155),
    ),
  ),
  // fillColor: Color.fromARGB(255, 217, 215, 215),
  filled: true,
  contentPadding:  EdgeInsets.all(8),
);
