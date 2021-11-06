import 'package:ecommerce_app/providers/auth_provider.dart';
import 'file:///D:/Flutter%20Projects/ecommerce_app/lib/screens/auth/register.dart';
import 'package:ecommerce_app/widgets/custom_textformfield.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/logo_icon.dart';
import 'package:ecommerce_app/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class login extends StatelessWidget {
  TextEditingController emailcontroller= TextEditingController();
  TextEditingController passwordcontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    var authprovider= Provider.of<auth_provider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo_icon(
                iconcolor: Colors.white,
                backgoundcolor: Colors.red,
                size: 80,
              ),
              SizedBox(height: 40,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red,style: BorderStyle.solid,width: 2)
                ),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTextFormField(controller: emailcontroller,label: 'Email',hinttext: 'Enter your email',),
                      CustomTextFormField(controller: passwordcontroller,label: 'Password',hinttext: 'Enter your password',),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("You don't have account , ",
                            style: TextStyle(color: Colors.black,fontSize: 13,),),
                          GestureDetector(
                            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>register())),
                            child: Text("Register",
                              style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(width: 5,),
                          custom_button(
                            ontap: (){
                              authprovider.signin_method(emailcontroller.text, passwordcontroller.text,context);
                            },
                            text: 'Login',
                            textcolor: Colors.white,
                            btncolor: Colors.red,
                          ),
                        ],
                      ),

                    ],
                )),
              ),
              SizedBox(height: 30,),
              social_button(
                ontap: (){
                  authprovider.signInWithGoogle(context);
                },
                text: 'Sign in with Google',
                textcolor: Colors.white,
                btncolor: Colors.red,
                iconData: Entypo.google_,
              ),
              SizedBox(height: 20,),
              social_button(
                ontap: (){
                  authprovider.signInWithFacebook(context);
                },
                text: 'Sign in with facebook',
                textcolor: Colors.white,
                btncolor: Colors.blue,
                iconData: Entypo.facebook,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
