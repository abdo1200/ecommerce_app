import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hinttext;

  CustomTextFormField({this.controller, this.label, this.hinttext});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hinttext,
      ),
    );
  }
}
