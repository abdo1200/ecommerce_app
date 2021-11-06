import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/widgets/Product/ColorsList.dart';
import 'package:ecommerce_app/widgets/Product/Favorite_button.dart';
import 'package:ecommerce_app/widgets/Product/ProductHeader.dart';
import 'package:ecommerce_app/widgets/Product/ProductsMainDetails.dart';
import 'package:ecommerce_app/widgets/Product/SizesList.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  final Product data;
  ProductDetails({this.data});

  @override
  Widget build(BuildContext context) {
    var customProvider = Provider.of<Custom_Provider>(context);
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Products')
          .where('name', isEqualTo: data.name)
          .snapshots(),
      builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        var items = snapshot.data?.docs ?? [];
        var data = items[0];
        return Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              ProductHeader(image: data['image']),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height - 340,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FavoriteButton(data['name']),
                      Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height - 420,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ProductMainDetails(
                              category: data['category'],
                              name: data['name'],
                              price: data['price'],
                              rate: data['rate'],
                            ),
                            ColorList(
                              data: data['colors'],
                              productName: data['name'],
                            ),
                            SizesList(
                              data: data['sizes'],
                              productName: data['name'],
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  custom_button(
                                    ontap: () {},
                                    btncolor: Colors.green,
                                    text: 'Add to cart',
                                    textcolor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
