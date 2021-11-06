import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SizesList extends StatelessWidget {
  final Map data;
  final String productName;
  SizesList({this.data, this.productName});

  @override
  Widget build(BuildContext context) {
    var customProvider = Provider.of<Custom_Provider>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              child: Text(
                'Sizes',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 86,
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
                          customProvider.SelectSize(
                              productName, key, data[key]);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.black,
                                      spreadRadius: .5)
                                ],
                              ),
                              child: Text(
                                key,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            data[key]
                                ? Container(
                                    color: Colors.green,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      SizedBox(width: 20)
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}