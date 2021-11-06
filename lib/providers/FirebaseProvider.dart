import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
}
