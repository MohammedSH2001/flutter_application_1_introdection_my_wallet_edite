import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/forwerbutton.dart';
import 'package:ionicons/ionicons.dart';

class settingitem extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconsColor;
  final IconData icon;
  final String? value;
  final Function() ontap;
  const settingitem({
    super.key,
    required this.title,
    required this.bgColor,
    required this.iconsColor,
    required this.icon,
    required this.ontap,  this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      width: double.infinity,
      child: Row(
        children: [
          
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
            child: Icon(
              icon,
              color: iconsColor,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          value!=null?
          Text(
            value!,
            style:const TextStyle(fontSize: 16, color: Colors.grey),
          ):const SizedBox(),
          SizedBox(
            width: 20,
          ),
          forwerButton(onTap: ontap,),
        ],
      ),
    );
  }
}
