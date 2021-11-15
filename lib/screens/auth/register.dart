import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/image_provider.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_textformfield.dart';
import 'package:ecommerce_app/widgets/logo_icon.dart';
import 'package:ecommerce_app/widgets/search_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class Register extends StatelessWidget {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<auth_provider>(context, listen: false);
    var imageProvider = Provider.of<ImagePickerProvider>(context);
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
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.red, style: BorderStyle.solid, width: 2)),
                child: Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    search_textfield(
                        textEditingController: name,
                        hinttext: 'Name',
                        backcolor: Colors.white,
                        iconData: Icons.person),
                    SizedBox(
                      height: 20,
                    ),
                    search_textfield(
                        textEditingController: emailcontroller,
                        hinttext: 'Email',
                        backcolor: Colors.white,
                        iconData: Icons.email),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.white,
                            child: (imageProvider.userImageFile != null)
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Row(
                                      children: <Widget>[
                                        Image.file(
                                          imageProvider.userImageFile,
                                          width: 70,
                                          height: 70,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          Icons.add_a_photo,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Change Image",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  )
                                : Row(
                                    children: [
                                      Icon(
                                        Icons.add_a_photo,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Choose image",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 20),
                                      ),
                                    ],
                                  ),
                            onPressed: () async {
                              await imageProvider.getimage();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    search_textfield(
                        textEditingController: passwordcontroller,
                        hinttext: 'Password',
                        backcolor: Colors.white,
                        iconData: Icons.security),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        custom_button(
                          ontap: () async {
                            Reference storageReference =
                                FirebaseStorage.instance.ref().child(
                                    basename(imageProvider.userImageFile.path));
                            UploadTask uploadTask = storageReference
                                .putFile(imageProvider.userImageFile);
                            await uploadTask.whenComplete(() {
                              print('File Uploaded');
                              storageReference.getDownloadURL().then((fileURL) {
                                authprovider.register_method(
                                    emailcontroller.text,
                                    passwordcontroller.text,
                                    name.text,
                                    fileURL,
                                    context);
                              });
                            });
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
