import 'package:flutter/material.dart';

class custom_button extends StatelessWidget {
  final Function ontap;
  final String text;
  final Color textcolor;
  final Color btncolor;

  custom_button({this.ontap, this.text, this.textcolor, this.btncolor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        decoration: BoxDecoration(
            color: btncolor,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Text(text,style: TextStyle(
            color: textcolor,
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),),
      )
      ,
    );
  }
}
