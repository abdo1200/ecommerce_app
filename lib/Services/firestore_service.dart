import 'package:ecommerce_app/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<category>> getCategories() {
    return _db.collection('Categories').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => category.fromMap(document.data()))
        .toList());
  }

  Stream<List<Product>> getopsalesproducts() {
    return _db
        .collection('Products')
        .where('isTopSale', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Product.fromMap(document.data()))
            .toList());
  }
}
