import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MultiDataStreamBuilder extends StatelessWidget {
  String categoryName;
  MultiDataStreamBuilder({this.categoryName});
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var CustomProvider = Provider.of<Custom_Provider>(context);
    Stream<QuerySnapshot> _ProductsStream = FirebaseFirestore.instance
        .collection('Products')
        .where('category', isEqualTo: categoryName)
        .snapshots();
    return Container(
      height: MediaQuery.of(context).size.height - 60,
      child: StreamBuilder<QuerySnapshot>(
        stream: _ProductsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            physics: ClampingScrollPhysics(),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Product productData = new Product();
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
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
                              ProductDetails(productData: productData)));
                },
                child: Container(
                    margin: EdgeInsets.only(
                        top: 15, bottom: 15, left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              spreadRadius: 1,
                              blurRadius: 5)
                        ]),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 40,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              data['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 40,
                          padding: EdgeInsets.only(left: 15, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['name'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: GoogleFonts.actor(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "\$" + data['price'],
                                style: GoogleFonts.aladin(
                                    textStyle: TextStyle(
                                        fontSize: 20, color: Colors.black)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.all(10),
                                  child: Text(data['category'])),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.email)
                                        .snapshots(),
                                    builder: (_, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }
                                      var item = snapshot.data ?? [];
                                      Map<String, dynamic> favdata =
                                          item.data();
                                      List favoriteProducts = [];
                                      if (favdata
                                          .containsKey('favouriteproducts')) {
                                        favoriteProducts =
                                            item['favouriteproducts'];
                                      }

                                      return GestureDetector(
                                        onTap: () {
                                          CustomProvider.addToFavorites(
                                            user.email,
                                            favoriteProducts,
                                            data['name'],
                                          );
                                        },
                                        child: favoriteProducts
                                                .contains(data['name'])
                                            ? Container(
                                                margin:
                                                    EdgeInsets.only(right: 30),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Colors.red,
                                                      style: BorderStyle.solid,
                                                      width: 2,
                                                    )),
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                              )
                                            : Container(
                                                margin:
                                                    EdgeInsets.only(right: 30),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Colors.red,
                                                      style: BorderStyle.solid,
                                                      width: 2,
                                                    )),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.black,
                                                  size: 20,
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
  }
}
