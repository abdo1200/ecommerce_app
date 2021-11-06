import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_textformfield.dart';
import 'package:ecommerce_app/widgets/logo_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class register extends StatelessWidget {
  TextEditingController emailcontroller= TextEditingController();
  TextEditingController passwordcontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {
  var authprovider= Provider.of<auth_provider>(context,listen: false);
  return Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 100),
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
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          custom_button(
                            ontap: (){
                              authprovider.register_method(emailcontroller.text, passwordcontroller.text,context);
                            },
                            text: 'Register',
                            textcolor: Colors.white,
                            btncolor: Colors.red,
                          ),
                        ],
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    ),
  );
  }


}
