import 'package:flutter/material.dart';

class SalesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 160,
          width: 400,
          margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/sale.jpg',fit: BoxFit.cover,)
          ),
        ),
        Container(
          height: 160,
          width: 400,
          margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20)
          ),
        ),
        Container(
          height: 160,
          width: 400,
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Container(
            color: Colors.red,
            child: Text('GET SALE 10% OFF',style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ],
    );
  }
}
