import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final String name;

  const FavoriteButton(this.name);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<auth_provider>(context);
    var CustomProvider = Provider.of<Custom_Provider>(context);

    return Container(
      width: double.infinity,
      height: 80,
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, color: Colors.black, spreadRadius: .5)
                  ]),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(authProvider.userdata.email)
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }
                var item = snapshot.data ?? [];
                return GestureDetector(
                  onTap: () {
                    CustomProvider.addToFavorites(authProvider.userdata.email,
                        item['favouriteproducts'], name);
                  },
                  child: item['favouriteproducts'].contains(name)
                      ? Container(
                          margin: EdgeInsets.only(right: 30),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.red,
                                style: BorderStyle.solid,
                                width: 2,
                              )),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(right: 30),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.red,
                                style: BorderStyle.solid,
                                width: 2,
                              )),
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
