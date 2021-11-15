import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/providers/FirebaseProvider.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/widgets/FloatingButton.dart';
import 'package:ecommerce_app/widgets/home/categories_list.dart';
import 'package:ecommerce_app/widgets/home/sales_card.dart';
import 'package:ecommerce_app/widgets/search_textfield.dart';
import 'package:ecommerce_app/widgets/home/top_sales_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class user_home extends StatelessWidget {
  TextEditingController searchcontroller = TextEditingController();
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    var authprovider = Provider.of<auth_provider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
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
    );
  }
}
