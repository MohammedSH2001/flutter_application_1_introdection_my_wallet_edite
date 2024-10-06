import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class forwerButton extends StatelessWidget {
  final Function() onTap;
  const forwerButton({
    super.key, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(Icons.chevron_right_outlined),
      ),
    );
  }
}