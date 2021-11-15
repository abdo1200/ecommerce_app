import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorList extends StatelessWidget {
  final String productName;
  ColorList({this.productName});

  @override
  Widget build(BuildContext context) {
    var customProvider = Provider.of<Custom_Provider>(context);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Products')
            .where('name', isEqualTo: productName)
            .snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          var items = snapshot.data?.docs ?? [];
          var data = items[0];
          customProvider.Selectedcolors.clear();
          return Container(
            child: Container(
                margin: EdgeInsets.only(left: 20),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Colors',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
                              width: 220,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: data['colors'].length,
                                itemBuilder: (context, index) {
                                  String key =
                                      data['colors'].keys.elementAt(index);
                                  if (data['colors'][key] == true) {
                                    customProvider.Selectedcolors.add(key);
                                  }
                                  return Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          customProvider.SelectColor(
                                              productName,
                                              key,
                                              data['colors'][key]);
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Color(int.parse(key)),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 1,
                                                    color: Colors.black,
                                                    spreadRadius: .1)
                                              ]),
                                          child: data['colors'][key]
                                              ? Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                )
                                              : Container(),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )),
          );
        });
  }
}
