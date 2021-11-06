import 'file:///D:/Flutter%20Projects/ecommerce_app/lib/widgets/user_navigaion.dart';
import 'file:///D:/Flutter%20Projects/ecommerce_app/lib/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class auth_provider extends ChangeNotifier {
  FirebaseAuth auth=FirebaseAuth.instance;
  UserCredential userCredential;
  var userdata ;

   Widget check_auth(){
     if(auth.currentUser!=null){
       userdata=auth.currentUser;
       print(userdata.email);
       return UserPages();
     }else{
       return login();
     }
  }

  register_method(String email,String password,BuildContext context) async{
    userCredential= await auth.createUserWithEmailAndPassword(email: email, password: password);
    userdata =userCredential.user;
    Navigator.pushReplacement(
        context,MaterialPageRoute(builder: (context)=> UserPages())
    );
    notifyListeners();
  }

  signin_method(String email,String password,BuildContext context) async{
    userCredential= await auth.signInWithEmailAndPassword(email: email, password: password);
    userdata =userCredential.user;
    Navigator.pushReplacement(
        context,MaterialPageRoute(builder: (context)=> UserPages())
    );
    notifyListeners();
  }

  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
    userdata =userCredential.user;
    Navigator.pushReplacement(
        context,MaterialPageRoute(builder: (context)=> UserPages())
    );
  }

  signInWithFacebook(BuildContext context) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);
    // Once signed in, return the UserCredential
    userCredential=await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    userdata =userCredential.user;
    Navigator.pushReplacement(
        context,MaterialPageRoute(builder: (context)=> UserPages())
    );
  }

  Logout_method(BuildContext context) async{
    auth.signOut();
    Navigator.pushReplacement(
        context,MaterialPageRoute(builder: (context)=> login())
    );
    notifyListeners();
  }
}