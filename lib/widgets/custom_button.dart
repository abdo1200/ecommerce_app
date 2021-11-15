import 'package:flutter/material.dart';

class custom_button extends StatelessWidget {
  final Function ontap;
  final String text;
  final Color textcolor;
  final Color btncolor;
  final IconData iconData;

  custom_button(
      {this.ontap, this.text, this.textcolor, this.btncolor, this.iconData});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: btncolor, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            (iconData != null)
                ? Row(
                    children: [
                      Icon(
                        iconData,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  )
                : Container(),
            Text(
              text,
              style: TextStyle(
                  color: textcolor, fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
