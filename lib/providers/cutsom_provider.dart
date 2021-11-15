import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/widgets/Add_Product/DynamicColorPicker.dart';
import 'package:ecommerce_app/widgets/Add_Product/textfielddynamic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Custom_Provider extends ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  int CartLenght;
  List<ColorBickerDynamic> listDynamic = [];
  String CategoryValue;
  bool editMode = false;
  User user = FirebaseAuth.instance.currentUser;

  List<TextFieldDynamic> sizelistDynamic = [];
  double cartTotal = 0.0;

  List Selectedcolors = [];
  String Selectesize = '';

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
          Map<String, dynamic> data = doc.data();
          if (data['sizes'].containsValue(true)) {
            Map<String, dynamic> sizes = data['sizes'];
            sizes.forEach((keydata, value) {
              if (value == true && keydata != key) {
                doc.reference.update({
                  "sizes." + keydata: false,
                });
              }
            });
          }
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
      await _db.collection('users').doc(email).update({
        'favouriteproducts': productList,
      });
    } else {
      productList.add(productName);
      await _db.collection('users').doc(email).update({
        'favouriteproducts': productList,
      });
    }
  }

  addToCart(
      {email,
      Map<String, dynamic> productList,
      productName,
      price,
      image}) async {
    if (productList.containsKey(productName)) {
      productList.remove(productName);
      await _db.collection('users').doc(email).update({
        'Cart': productList,
      });
    } else {
      productList.addAll({
        productName: {
          'price': price,
          'colors': Selectedcolors,
          'size': Selectesize,
          'image': image
        }
      });
      await _db.collection('users').doc(email).update({
        'Cart': productList,
      });
    }
    notifyListeners();
  }

  addToorders(
      {Map<String, dynamic> newproductList,
      Map<String, dynamic> oldproductList,
      email}) async {
    oldproductList.addAll(newproductList);
    await _db.collection('users').doc(email).update({
      'orders': oldproductList,
    });
    await _db.collection('users').doc(email).update({
      'Cart': {},
    });
    notifyListeners();
  }

  DeleteItemOrders({
    email,
    Map<String, dynamic> productList,
    productName,
  }) async {
    productList.remove(productName);
    await _db.collection('users').doc(email).update({
      'orders': productList,
    });

    notifyListeners();
  }

  Future<int> getCartLenght(email) async {
    await _db.collection('users').doc(email).get().then((snapshot) {
      Map<String, dynamic> data = snapshot.data() ?? [];
      Map<String, dynamic> Cart = data['Cart'];
      CartLenght = Cart.length;
    });
    return Future.value(CartLenght);
  }

  Future<Product> getHomeProduct() async {
    Product product = new Product();
    await _db
        .collection('Products')
        .where('homeSale', isEqualTo: true)
        .get()
        .then((snapshots) {
      Map<String, dynamic> data = snapshots.docs[0].data() ?? [];
      product = Product(
          image: data['image'],
          name: data['name'],
          category: data['category'],
          colors: data['colors'],
          description: data['description'],
          price: data['price'],
          sizes: data['sizes']);
    });
    return Future.value(product);
  }

  enableEditMode() {
    editMode = !editMode;
    notifyListeners();
  }

  editeUser(name) {
    user.updateDisplayName(name);
    user.reload();
    notifyListeners();
  }
}
