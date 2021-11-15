import 'package:ecommerce_app/providers/FirebaseProvider.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/widgets/FloatingButton.dart';
import 'package:ecommerce_app/widgets/MultiDataStreamBuilder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Cart.dart';

class CategoryProducts extends StatelessWidget {
  final String CategoryName;
  CategoryProducts({this.CategoryName});

  @override
  Widget build(BuildContext context) {
    var firebase_provider = Provider.of<FirebaseProvider>(context);
    var custom = Provider.of<Custom_Provider>(context);
    var authprovider = Provider.of<auth_provider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            CategoryName + ' Products',
            style: GoogleFonts.actor(),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: MultiDataStreamBuilder(
              categoryName: CategoryName,
            ),
          ),
        ),
        floatingActionButton: FloatingButton());
  }
}
