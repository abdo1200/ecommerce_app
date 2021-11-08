import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/providers/image_provider.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/widgets/Add_Product/CustomGridView.dart';
import 'package:ecommerce_app/widgets/Add_Product/DropDown.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/search_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class AddProduct extends StatelessWidget {
  TextEditingController name = TextEditingController(),
      price = TextEditingController(),
      description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<auth_provider>(context);
    var provider = Provider.of<Custom_Provider>(context);
    var imageProvider = Provider.of<ImagePickerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => authprovider.Logout_method(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: search_textfield(
                  backcolor: Colors.white,
                  hinttext: 'Product Name',
                  textEditingController: name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: search_textfield(
                  backcolor: Colors.white,
                  hinttext: 'Product Description',
                  textEditingController: description,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: search_textfield(
                  backcolor: Colors.white,
                  hinttext: 'Product Price',
                  textEditingController: price,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    custom_button(
                      ontap: () {
                        provider.addcolorpicker();
                      },
                      textcolor: Colors.red,
                      btncolor: Colors.white,
                      text: 'Add Color',
                    ),
                    CustomGridView(
                      list: provider.listDynamic,
                      Axiscount: 7,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    custom_button(
                      ontap: () {
                        provider.addtextform();
                      },
                      textcolor: Colors.red,
                      btncolor: Colors.white,
                      text: 'Add Size',
                    ),
                    CustomGridView(
                      list: provider.sizelistDynamic,
                      Axiscount: 5,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  color: Colors.white,
                  child: DropDown(),
                ),
              ),
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
                                  borderRadius: BorderRadius.circular(50)),
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
                                          color: Colors.red, fontSize: 20)),
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
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.all(10),
                    child: custom_button(
                      ontap: () async {
                        Product productData = new Product();
                        Map<String, bool> ColorsList = {};
                        Map<String, bool> SizesList = {};
                        provider.listDynamic.forEach((widget) {
                          ColorsList[widget.colorvalue.value.toString()] =
                              false;
                        });
                        provider.sizelistDynamic.forEach((widget) {
                          SizesList[widget.controller.text] = false;
                        });
                        Reference storageReference = FirebaseStorage.instance
                            .ref()
                            .child(basename(imageProvider.userImageFile.path));
                        UploadTask uploadTask = storageReference
                            .putFile(imageProvider.userImageFile);
                        await uploadTask.whenComplete(() {
                          print('File Uploaded');
                          storageReference.getDownloadURL().then((fileURL) {
                            provider.addProduct(
                              desc: description.text,
                              name: name.text,
                              image: fileURL,
                              price: price.text,
                              colors: ColorsList,
                              sizes: SizesList,
                              category: provider.CategoryValue,
                              user_email: authprovider.userdata.email,
                            );
                            productData = Product(
                              description: description.text,
                              name: name.text,
                              image: fileURL,
                              price: price.text,
                              colors: ColorsList,
                              sizes: SizesList,
                              category: provider.CategoryValue,
                            );
                          });
                        });
                        provider.listDynamic = [];
                        provider.sizelistDynamic = [];
                        imageProvider.userImageFile = null;
                        imageProvider.imgurl = '';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetails(productData: productData)));
                      },
                      btncolor: Colors.red,
                      text: 'Add Product',
                      textcolor: Colors.white,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
