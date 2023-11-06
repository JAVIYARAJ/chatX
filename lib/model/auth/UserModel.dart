import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late final String id;
  late final String name;
  late final String email;
  late final String password;
  late final int colorId;
  late final String bio;
  late final String? image;
  late final String? createdAt;
  late final String? updatedAt;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.colorId,
      required this.bio,
      this.image,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "colorId": colorId,
        "bio": bio,
        "image": image,
        "createdAt": createdAt,
        "updatedAt": updatedAt
      };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      colorId: map["colorId"],
      bio: map["bio"],
      image: map["image"],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt']
    );
  }

  static UserModel fromSnapShot(DocumentSnapshot<dynamic> snapshot) {
    var result = snapshot.data();

    return UserModel(
        id: result["id"],
        name: result["name"],
        email: result["email"],
        password: result["password"],
        colorId: result["colorId"],
        image: result["image"],
        bio: result["bio"],
        createdAt: result["createdAt"],
        updatedAt: result["updatedAt"]);
  }
}
