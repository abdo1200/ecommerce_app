import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var custom = Provider.of<Custom_Provider>(context);
    return FutureBuilder<Product>(
        future: custom.getHomeProduct(),
        builder: (_, AsyncSnapshot<Product> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(productData: snapshot.data)));
            },
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: 400,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        snapshot.data.image,
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  height: 200,
                  width: 400,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  height: 200,
                  width: 400,
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Container(
                    color: Colors.red,
                    child: Text(
                      'GET SALE 10% OFF',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
