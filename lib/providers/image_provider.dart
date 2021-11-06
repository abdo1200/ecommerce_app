import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImagePickerProvider extends ChangeNotifier {
  File userImageFile;
  String imgurl;

  Future getimage() async {
    final ImagePicker _picker = ImagePicker();
    XFile userImageXFile = await _picker.pickImage(source: ImageSource.gallery);
    userImageFile = File(userImageXFile.path);
    print(userImageFile);
    notifyListeners();
  }
}
