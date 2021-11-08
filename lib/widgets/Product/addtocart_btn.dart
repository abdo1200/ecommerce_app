import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart_button extends StatelessWidget {
  final String name;
  final String price;
  Cart_button({this.name, this.price});

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
                .doc(authProvider.userdata.email)
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              DocumentSnapshot item = snapshot.data ?? [];
              Map<String, dynamic> data = item.data();
              Map<String, dynamic> Cart;
              if (data.containsKey('Cart')) {
                Cart = item['Cart'];
              }

              return data.containsKey('Cart')
                  ? custom_button(
                      ontap: () async {
                        await customProvider.addToCart(
                          email: authProvider.userdata.email,
                          price: price,
                          productList: item['Cart'],
                          productName: name,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Cart.containsKey(name)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Reomved from cart successfully',
                                        style: TextStyle(fontSize: 20)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.check, color: Colors.white),
                                  ],
                                )
                              : Row(
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
                          email: authProvider.userdata.email,
                          price: price,
                          productList: {},
                          productName: name,
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
