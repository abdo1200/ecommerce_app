import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/FirebaseProvider.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/widgets/MultiDataStreamBuilder.dart';
import 'package:ecommerce_app/widgets/ProductList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryProducts extends StatelessWidget {
  final String CategoryName;
  CategoryProducts({this.CategoryName});

  @override
  Widget build(BuildContext context) {
    var firebase_provider = Provider.of<FirebaseProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Products',
            style: GoogleFonts.actor(),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: MultiDataStreamBuilder(
              categoryName: CategoryName,
            ),
          ),
        ));
  }
}
