import 'package:flutter/material.dart';

class ProductMainDetails extends StatelessWidget {
  final String name;
  final String price;
  final String category;
  final String rate;

  const ProductMainDetails({this.name, this.price, this.category, this.rate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(10),
                    child: Text(category),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '\$' + price,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Container(
                  child: Row(
                children: [
                  Text(
                    rate,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.red,
                    size: 25,
                  ),
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }
}
