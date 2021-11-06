import 'package:flutter/material.dart';

class ProductHeader extends StatelessWidget {
  final String image;
  const ProductHeader({this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
