import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/widgets/FloatingButton.dart';
import 'package:ecommerce_app/widgets/Product/ColorsList.dart';
import 'package:ecommerce_app/widgets/Product/Favorite_button.dart';
import 'package:ecommerce_app/widgets/Product/ProductHeader.dart';
import 'package:ecommerce_app/widgets/Product/ProductsMainDetails.dart';
import 'package:ecommerce_app/widgets/Product/SizesList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/widgets/Product/addtocart_btn.dart';

import 'Cart.dart';

class ProductDetails extends StatelessWidget {
  final Product productData;
  ProductDetails({this.productData});

  @override
  Widget build(BuildContext context) {
    var customProvider = Provider.of<Custom_Provider>(context);
    var authprovider = Provider.of<auth_provider>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ProductHeader(image: productData.image),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 2 / 3 - 20,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FavoriteButton(productData.name),
                    Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ProductMainDetails(
                            category: productData.category,
                            name: productData.name,
                            price: productData.price,
                            rate: '4.0',
                          ),
                          ColorList(
                            productName: productData.name,
                          ),
                          SizesList(
                            productName: productData.name,
                          ),
                          SizedBox(height: 10),
                          Cart_button(
                            name: productData.name,
                            price: productData.price,
                            image: productData.image,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingButton(),
      bottomSheet: Padding(padding: EdgeInsets.only(bottom: 100.0)),
    );
  }
}
