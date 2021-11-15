import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<auth_provider>(context);
    var CustomProvider = Provider.of<Custom_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.email)
                  .snapshots(),
              builder: (_, favsnapshot) {
                if (favsnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                var item = favsnapshot.data ?? [];
                Map<String, dynamic> data = item.data();
                Map<String, dynamic> CartProduct = {};
                Map<String, dynamic> newproducts = {};
                Map<String, dynamic> oldOrders = {};
                if (data.containsKey('Cart')) {
                  CartProduct = item['Cart'];
                }
                if (data.containsKey('orders')) {
                  oldOrders = item['orders'];
                }
                CustomProvider.cartTotal = 0;
                newproducts.addAll(CartProduct);
                return CartProduct.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.all(20),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 200,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(.7),
                                    borderRadius: BorderRadius.circular(200))),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'No Products Added Yet !',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height - 60,
                            child: ListView.builder(
                                itemCount: CartProduct.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  double total = 0;
                                  String key;
                                  if (CartProduct.length != index) {
                                    key = CartProduct.keys.elementAt(index);
                                    total = double.parse(
                                            CartProduct[key]['price']) *
                                        CartProduct[key]['colors'].length;
                                    CustomProvider.cartTotal += total;
                                  }

                                  return (CartProduct.length == index)
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('Total price : ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      CustomProvider.cartTotal
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25))
                                                ],
                                              ),
                                              custom_button(
                                                btncolor: Colors.red,
                                                ontap: () {
                                                  CustomProvider.addToorders(
                                                      email: user.email,
                                                      newproductList:
                                                          newproducts,
                                                      oldproductList:
                                                          oldOrders);
                                                },
                                                text: 'Buy',
                                                textcolor: Colors.white,
                                              )
                                            ],
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 2,
                                                  color: Colors.black,
                                                  spreadRadius: .5)
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 140,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        CartProduct[key]
                                                            ['image'],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${key}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text('Colors : '),
                                                          for (int i = 0;
                                                              i <
                                                                  CartProduct[key]
                                                                          [
                                                                          'colors']
                                                                      .length;
                                                              i++)
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 5),
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      blurRadius:
                                                                          1,
                                                                      color: Colors
                                                                          .black,
                                                                      spreadRadius:
                                                                          .5)
                                                                ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color: Color(int.parse(
                                                                    CartProduct[
                                                                            key]
                                                                        [
                                                                        'colors'][i])),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      Text(
                                                          'Size : ${CartProduct[key]['size']}'),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              'Quantity : ${CartProduct[key]['colors'].length}'),
                                                          SizedBox(
                                                            width: 30,
                                                          ),
                                                          Text(
                                                              'price : ${CartProduct[key]['price']}'),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text('total : '),
                                                          Text(
                                                              '${total.toString()}',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  CustomProvider.addToCart(
                                                      email: user.email,
                                                      price: CartProduct[key]
                                                          ['price'],
                                                      productList: CartProduct,
                                                      productName: key,
                                                      image: CartProduct[key]
                                                          ['image']);
                                                },
                                                child: Container(
                                                  width: 50,
                                                  height: 140,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(20),
                                                      bottomRight:
                                                          Radius.circular(20),
                                                    ),
                                                    color: Colors.red,
                                                  ),
                                                  child: Icon(
                                                    Icons.delete_forever,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                }),
                          ),
                        ],
                      );
              })),
    );
  }
}
