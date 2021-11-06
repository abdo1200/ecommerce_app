import 'package:flutter/material.dart';

class TextFieldDynamic extends StatelessWidget {
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(blurRadius: 1, color: Colors.black, spreadRadius: .1)
          ]),
      child: new TextField(
        textAlign: TextAlign.center,
        controller: controller,
        decoration: new InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        ),
      ),
    );
  }
}
