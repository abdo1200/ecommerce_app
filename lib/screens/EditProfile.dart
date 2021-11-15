import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/screens/profileInfo.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/search_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Custom_Provider>(context);
    nameController.text = user.displayName;
    emailcontroller.text = user.email;
    phoneNumber.text = user.phoneNumber;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            Icon(
                              Icons.exit_to_app,
                              size: 30,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 5,
                                  spreadRadius: .1)
                            ], borderRadius: BorderRadius.circular(50)),
                            child: (user.photoURL != null)
                                ? Container(
                                    height: 100,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        user.photoURL,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 100,
                                  ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            (user.displayName != null)
                                ? user.displayName
                                : user.email,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: search_textfield(
                textEditingController: nameController,
                backcolor: Colors.white,
                iconData: Icons.person,
                hinttext: 'Name',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: search_textfield(
                textEditingController: emailcontroller,
                backcolor: Colors.white,
                iconData: Icons.email,
                hinttext: 'Email',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: search_textfield(
                textEditingController: phoneNumber,
                backcolor: Colors.white,
                iconData: Icons.phone_android,
                hinttext: 'Phone Number',
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                custom_button(
                  text: 'Save',
                  btncolor: Colors.green,
                  iconData: Icons.save,
                  ontap: () async {
                    await provider.editeUser(nameController.text);
                    await user.reload();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => profileInfo()));
                  },
                  textcolor: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
