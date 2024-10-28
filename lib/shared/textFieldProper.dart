import 'package:flutter/material.dart';

class CustomBorders {
  static OutlineInputBorder defaultBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.blue,
        width: 2.0,
      ),
    );
  }

  static OutlineInputBorder focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(
        color: Colors.blueAccent,
        width: 3.0,
      ),
    );
  }

  static OutlineInputBorder enabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 0.0,
      ),
    );
  }
}
