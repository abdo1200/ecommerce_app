import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorList extends StatelessWidget {
  final Map data;
  final String productName;
  ColorList({this.data, this.productName});

  @override
  Widget build(BuildContext context) {
    var customProvider = Provider.of<Custom_Provider>(context);
    return Container(
      child: Container(
          margin: EdgeInsets.only(left: 20),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
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
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            String key = data.keys.elementAt(index);
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    customProvider.SelectColor(
                                        productName, key, data[key]);
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color(int.parse(key)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 1,
                                              color: Colors.black,
                                              spreadRadius: .1)
                                        ]),
                                    child: data[key]
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
  }
}
