import 'package:ecommerce_app/providers/FirebaseProvider.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/widgets/home/categories_list.dart';
import 'package:ecommerce_app/widgets/home/sales_card.dart';
import 'package:ecommerce_app/widgets/search_textfield.dart';
import 'package:ecommerce_app/widgets/home/top_sales_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class user_home extends StatelessWidget {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    var authprovider = Provider.of<auth_provider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    authprovider.userdata.photoURL,
                    width: 40,
                  )),
              SizedBox(
                width: 10,
              ),
              Text(
                'Hi, ${authprovider.userdata.displayName}',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Provider.of<auth_provider>(context, listen: false)
                          .Logout_method(context);
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.black,
                    )),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: search_textfield(
                hinttext: 'Search for any item',
                iconData: Icons.search,
                backcolor: Colors.grey[200],
              ),
            ),
            CategoriesSlide(),
            SalesCard(),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'TOP SALES',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            TopSalesList()
          ],
        ),
      ),
    );
  }
}
