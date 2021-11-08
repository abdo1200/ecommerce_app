import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class TopSalesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<List<Product>>(context);
    var CustomProvider = Provider.of<Custom_Provider>(context);
    var authProvider = Provider.of<auth_provider>(context);
    return Container(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: products?.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(productData: products[index])));
            },
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: 300,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        products[index].image,
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  height: 200,
                  width: 300,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  height: 200,
                  width: 300,
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              ' \$' + products[index].price + ' ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(authProvider.userdata.email)
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          var item = snapshot.data ?? [];
                          return GestureDetector(
                            onTap: () {
                              CustomProvider.addToFavorites(
                                authProvider.userdata.email,
                                item['favouriteproducts'],
                                products[index].name,
                              );
                            },
                            child: item['favouriteproducts']
                                    .contains(products[index].name)
                                ? Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
