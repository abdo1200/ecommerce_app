import 'package:flutter/material.dart';

class logo_icon extends StatelessWidget {
  final Color iconcolor;
  final Color backgoundcolor;
  final double size;

  const logo_icon({this.iconcolor, this.backgoundcolor, this.size});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
          color: backgoundcolor,
          padding: EdgeInsets.all(30),
          child: Icon(Icons.local_grocery_store_rounded,size: size,color: iconcolor,)
      ),
    );
  }
}
