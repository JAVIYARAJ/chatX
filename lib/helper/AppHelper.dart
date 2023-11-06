import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AppHelper{

  static showSnackBar(String title,String message,SnackPosition position){
    Get.snackbar(title,message,snackPosition:position,margin: const EdgeInsets.only(bottom: 10));
  }

  static String encryptPassWord(String password){
    const salt="Rjcoding";
    var bytes=utf8.encode('$salt$password');
    final hashPassword=sha256.convert(bytes);
    return hashPassword.toString();
  }


  static Future<Uint8List?> pickImage(ImageSource imageSource) async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: imageSource);

    if (file != null) {
      return await file.readAsBytes();
    }
    return null;
  }

}