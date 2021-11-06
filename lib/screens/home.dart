import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/logo_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/login.dart';
class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var authprovider= Provider.of<auth_provider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logo_icon(
              iconcolor: Colors.red,
              backgoundcolor: Colors.white,
              size: 100,
            ),
            SizedBox(height: 20,),
            Text("E-Store",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
            SizedBox(height:20),
            custom_button(
              ontap: (){
                Navigator.pushReplacement(
                    context,MaterialPageRoute(builder: (context)=> login())
                );
              },
              text: 'Login',
              btncolor: Colors.white,
              textcolor: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
