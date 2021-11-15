import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart_button extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  Cart_button({this.name, this.price, this.image});
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var customProvider = Provider.of<Custom_Provider>(context);
    var authProvider = Provider.of<auth_provider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.email)
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              DocumentSnapshot item = snapshot.data ?? [];
              Map<String, dynamic> data = item.data();
              Map<String, dynamic> Cart;
              if (data.containsKey('Cart')) {
                Cart = data['Cart'];
              }
              return data.containsKey('Cart')
                  ? custom_button(
                      ontap: () async {
                        if (customProvider.Selectedcolors.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('please select color'),
                            backgroundColor: Colors.red,
                          ));
                        } else if (customProvider.Selectesize == '') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('please select size'),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          await customProvider.addToCart(
                            email: user.email,
                            price: price,
                            productList: Cart,
                            productName: name,
                            image: image,
                          );
                        }
                      },
                      btncolor:
                          Cart.containsKey(name) ? Colors.red : Colors.blue,
                      text: Cart.containsKey(name)
                          ? 'Remove from Cart'
                          : 'Add to cart',
                      textcolor: Colors.white,
                      iconData: Cart.containsKey(name)
                          ? Icons.remove_shopping_cart
                          : Icons.add_shopping_cart,
                    )
                  : custom_button(
                      ontap: () async {
                        await customProvider.addToCart(
                          email: user.email,
                          price: price,
                          productList: {},
                          productName: name,
                          image: image,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Added to cart successfully',
                                  style: TextStyle(fontSize: 20)),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.check, color: Colors.white),
                            ],
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                        ));
                      },
                      btncolor: Colors.blue,
                      text: 'Add to cart',
                      textcolor: Colors.white,
                      iconData: Icons.add_shopping_cart,
                    );
            },
          )
        ],
      ),
    );
  }
}
