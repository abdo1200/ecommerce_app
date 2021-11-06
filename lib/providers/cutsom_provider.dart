import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/widgets/DynamicColorPicker.dart';
import 'package:ecommerce_app/widgets/textfielddynamic.dart';
import 'package:flutter/material.dart';

class Custom_Provider extends ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  List<ColorBickerDynamic> listDynamic = [];
  String CategoryValue;

  List<TextFieldDynamic> sizelistDynamic = [];

  addcolorpicker() {
    listDynamic.add(new ColorBickerDynamic());
    notifyListeners();
  }

  addtextform() {
    sizelistDynamic.add(new TextFieldDynamic());
    notifyListeners();
  }

  void chooseCategory(value) {
    CategoryValue = value;
    notifyListeners();
  }

  addProduct(
      {name, user_email, desc, colors, price, image, category, sizes}) async {
    DocumentReference ref = await _db.collection('Products').add({
      'description': desc,
      'user_email': user_email,
      'name': name,
      'colors': colors,
      'price': price,
      'image': image,
      'category': category,
      'sizes': sizes,
      'isTopSale': false,
      'homeSale': false,
      'rate': '4.5',
    });
  }

  SelectColor(name, key, selectvalue) async {
    QuerySnapshot snapshot =
        await _db.collection('Products').where('name', isEqualTo: name).get();
    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach((doc) {
        if (selectvalue == false) {
          doc.reference.update({
            "colors." + key: true,
          });
        } else {
          doc.reference.update({
            "colors." + key: false,
          });
        }
      });
    }
    notifyListeners();
  }

  SelectSize(name, key, selectvalue) async {
    QuerySnapshot snapshot =
        await _db.collection('Products').where('name', isEqualTo: name).get();
    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach((doc) {
        if (selectvalue == false) {
          doc.reference.update({
            "sizes." + key: true,
          });
        } else {
          doc.reference.update({
            "sizes." + key: false,
          });
        }
      });
    }
    notifyListeners();
  }

  addToFavorites(String email, List productList, String productName) async {
    if (productList.contains(productName)) {
      productList.remove(productName);
      await _db.collection('users').doc(email).set({
        'favouriteproducts': productList,
      });
    } else {
      productList.add(productName);
      await _db.collection('users').doc(email).set({
        'favouriteproducts': productList,
      });
    }
  }
}
