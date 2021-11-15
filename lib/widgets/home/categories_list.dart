import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/providers/FirebaseProvider.dart';
import 'package:ecommerce_app/screens/CategoryProducts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesSlide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<List<category>>(context);
    var firebase_provider = Provider.of<FirebaseProvider>(context);
    return Container(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories?.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryProducts(
                            CategoryName: categories[index].name,
                          )));
            },
            child: Stack(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    width: 140,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          categories[index].image,
                          fit: BoxFit.cover,
                          width: 140,
                          height: 80,
                        ))),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 140,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(.5)),
                  child: Text(
                    categories[index].name.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
