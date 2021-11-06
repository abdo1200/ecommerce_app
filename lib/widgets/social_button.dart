import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class social_button extends StatelessWidget {
  final Function ontap;
  final String text;
  final Color textcolor;
  final Color btncolor;
  final IconData iconData;

  social_button({this.ontap, this.text, this.textcolor, this.btncolor,this.iconData});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 280,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        decoration: BoxDecoration(
            color: btncolor,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData,color: Colors.white,size: 20,),
            SizedBox(width: 20,),
            Text(text,style: TextStyle(
                color: textcolor,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
          ],
        ),
      )
      ,
    );
  }
}
