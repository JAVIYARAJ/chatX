import 'dart:math';
import 'dart:typed_data';

import 'package:chat_x/model/auth/FirebaseResult.dart';
import 'package:chat_x/model/auth/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../util/Util.dart';

class FirebaseHelper {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final fireStore = FirebaseFirestore.instance;

  Future<FirebaseResult> userLogin(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return FirebaseResult(
          status: "success", message: "Login Successfully", data: "");
    } catch (e) {
      return FirebaseResult(status: "failed", message: e.toString(), data: "");
    }
  }

  Future<FirebaseResult> userRegister(String email, String name,
      String password, String bio, Uint8List image) async {
    try {
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var uploadResult = await uploadImageToStorage(image);
      if (uploadResult.status == "success") {
        saveData(
            result.user!.uid!, name, email, password, bio, uploadResult.data);
        return FirebaseResult(
            status: "success", message: "Register Successfully", data: "");
      } else {
        return FirebaseResult(
            status: "failed", message: e.toString(), data: "");
      }
    } catch (e) {
      return FirebaseResult(status: "failed", message: e.toString(), data: "");
    }
  }

  Future<FirebaseResult> uploadImageToStorage(Uint8List file) async {
    try {
      String id = const Uuid().v1();
      var result = await storage.ref("users/images/$id.png").putData(file);
      var imageUrl = await result.ref.getDownloadURL();
      return FirebaseResult(
          status: "success",
          message: "file upload successfully",
          data: imageUrl);
    } catch (e) {
      return FirebaseResult(status: "failed", message: e.toString(), data: "");
    }
  }

  Future<FirebaseResult> saveData(String uid, String name, String email,
      String password, String bio, String imagePath) async {
    try {
      int randomNum = Random().nextInt(10) + 1;
      String date =
          Util.convertDateToString(DateTime.now(), "yyyy-MM-dd HH:mm:ss");
      var user = UserModel(
          id: uid,
          name: name,
          email: email,
          password: password,
          colorId: randomNum,
          bio: bio,
          image: imagePath,
          createdAt: date,
          updatedAt: date);

      var result =
          await fireStore.collection("users").doc(uid).set(user.toJson());
      return FirebaseResult(
          status: "success", message: "data save successfully", data: "");
    } catch (e) {
      return FirebaseResult(status: "failed", message: e.toString(), data: "");
    }
  }

  Future<UserModel> getUserData(String id) async {
    var result= await fireStore.collection("users").doc(id).get();
    return UserModel.fromSnapShot(result);
  }

  void logout() async{
    await firebaseAuth.signOut();
  }
}
