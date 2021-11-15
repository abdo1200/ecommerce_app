import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/widgets/FloatingButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavouritProducts extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<auth_provider>(context);
    var CustomProvider = Provider.of<Custom_Provider>(context);

    return Container(
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
              List favoriteProducts = [];
              if (data.containsKey('favouriteproducts')) {
                favoriteProducts = item['favouriteproducts'];
              }
              return favoriteProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: EdgeInsets.all(20),
                              child: Icon(
                                Icons.favorite,
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
                            'No Favorite Yet !',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: item['favouriteproducts']?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Container(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Products')
                                    .where('name',
                                        isEqualTo: item['favouriteproducts']
                                            [index])
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Something went wrong');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text("Loading");
                                  }

                                  return ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: ClampingScrollPhysics(),
                                    children: snapshot.data.docs
                                        .map((DocumentSnapshot document) {
                                      Map<String, dynamic> data = document
                                          .data() as Map<String, dynamic>;
                                      Product productData = new Product();

                                      productData = Product(
                                        description: data['description'],
                                        name: data['name'],
                                        image: data['image'],
                                        price: data['price'],
                                        colors: data['colors'],
                                        sizes: data['sizes'],
                                        category: data['category'],
                                      );
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                          productData:
                                                              productData)));
                                        },
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            margin: EdgeInsets.only(
                                                top: 30, left: 20, right: 20),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black,
                                                      spreadRadius: 1,
                                                      blurRadius: 5)
                                                ]),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  height: 200,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      data['image'],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      40,
                                                  padding: EdgeInsets.only(
                                                      left: 15, top: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data['name'],
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: false,
                                                        style: GoogleFonts.actor(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "\$" + data['price'],
                                                        style: GoogleFonts.aladin(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black)),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey[200],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Text(data[
                                                              'category'])),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        children: [
                                                          StreamBuilder(
                                                            stream:
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .doc(user
                                                                        .email)
                                                                    .snapshots(),
                                                            builder:
                                                                (_, snapshot) {
                                                              if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .waiting) {
                                                                return CircularProgressIndicator();
                                                              }
                                                              var item = snapshot
                                                                      .data ??
                                                                  [];
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  CustomProvider.addToFavorites(
                                                                      user
                                                                          .email,
                                                                      item[
                                                                          'favouriteproducts'],
                                                                      data[
                                                                          'name']);
                                                                },
                                                                child: item['favouriteproducts']
                                                                        .contains(
                                                                            data['name'])
                                                                    ? Container(
                                                                        margin: EdgeInsets.only(
                                                                            right:
                                                                                30),
                                                                        padding:
                                                                            EdgeInsets.all(10),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(20),
                                                                            color: Colors.white,
                                                                            border: Border.all(
                                                                              color: Colors.red,
                                                                              style: BorderStyle.solid,
                                                                              width: 2,
                                                                            )),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .favorite,
                                                                          color:
                                                                              Colors.red,
                                                                          size:
                                                                              20,
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        margin: EdgeInsets.only(
                                                                            right:
                                                                                30),
                                                                        padding:
                                                                            EdgeInsets.all(10),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(20),
                                                                            color: Colors.white,
                                                                            border: Border.all(
                                                                              color: Colors.red,
                                                                              style: BorderStyle.solid,
                                                                              width: 2,
                                                                            )),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .favorite_border,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              20,
                                                                        ),
                                                                      ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            );
                          }),
                    );
            }));
  }
}
