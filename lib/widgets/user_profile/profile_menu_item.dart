import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenuItem extends StatelessWidget {
  final Color borderColor;
  final String label;
  final Function ontap;
  final IconData iconData;

  const ProfileMenuItem({this.borderColor, this.label, this.ontap,this.iconData});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.centerLeft,
        width: 390,
        height: 60,
        padding: EdgeInsets.only(left: 20,right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                left :BorderSide(color: borderColor, width: 5, style: BorderStyle.solid)
            ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,style: GoogleFonts.actor(
              textStyle: TextStyle(
                  fontSize: 20
              ),
            )),
            Icon(iconData,size: 30,color: borderColor,)
          ],
        ),
      ),
    );
  }
}
