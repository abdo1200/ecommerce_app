import 'file:///D:/Flutter%20Projects/ecommerce_app/lib/screens/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/screens/auth/CompleteInfo.dart';
import 'package:ecommerce_app/widgets/home/user_navigaion.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class auth_provider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential userCredential;

  var userdata;
  var email;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  user_model userModel = new user_model();

  Widget check_auth() {
    if (auth.currentUser != null) {
      return UserPages();
    } else {
      return login();
    }
  }

  register_method(String email, String password, String name, String image,
      BuildContext context) async {
    userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await userCredential.user.updateDisplayName(name);
    await userCredential.user.updatePhotoURL(image);
    userdata = userCredential.user;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .set({'name': name, 'email': email, 'image': image, 'Cart': {}});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UserPages()));
    notifyListeners();
  }

  signin_method(String email, String password, BuildContext context) async {
    userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    userdata = userCredential.user;
    await GetUser(email);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UserPages()));
    notifyListeners();
  }

  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    userdata = userCredential.user;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user.email)
        .set({
      'name': userdata.displayName,
      'email': userdata.email,
      'image': userdata.photoURL,
    }, SetOptions(merge: true));
    await GetUser(userdata.email);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UserPages()));
  }

  signInWithFacebook(BuildContext context) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken.token);
    // Once signed in, return the UserCredential
    userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    userdata = userCredential.user;
    Future<QuerySnapshot> qs = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: userdata.uid)
        .get();
    await qs.then((value) async {
      if (value.docs.isEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CompleteInfo()));
      } else {
        await GetUser(value.docs[0]['email']);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserPages()));
      }
    });
    //print(newuser);
  }

  Logout_method(BuildContext context) async {
    auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => login()));
    notifyListeners();
  }

  Future<user_model> GetUser(email) async {
    await _db.collection('users').doc(email).get().then((snapshot) {
      Map<String, dynamic> data = snapshot.data() ?? [];
      userModel = user_model(
          email: data['email'], image: data['image'], name: data['name']);
      print(userModel);
    });

    return Future.value(userModel);
  }

  GetUserBYid(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) async {
      await GetUser(value.docs[0]['email']);
    });
  }
}
