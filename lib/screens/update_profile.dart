import 'package:chat_x/model/auth/UserModel.dart';
import 'package:chat_x/preference/PrefHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/FirebaseHelper.dart';
import '../widget/custom_text_filed.dart';
import '../widget/reusable_widgets.dart';
class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController bioController=TextEditingController();

  late UserModel userModel;

  void getProfileData(){
    setState(() {
      userModel=PrefHelper.getUserProfileData();
    });
    if(userModel!=null){
      nameController.text=userModel.name;
      emailController.text=userModel.email;
      bioController.text=userModel.bio;
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      ReusableProfileCard(icon: Icons.arrow_back, onTap: () {
                        Get.back();
                      }),
                      const Expanded(
                        child: Text(
                          "Edit Profile",
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Card(
                        color: Colors.blueAccent.withAlpha(100),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Image(
                            fit: BoxFit.cover,
                            image:userModel.image != null ? NetworkImage(userModel.image!) : const NetworkImage(
                                "https://images.unsplash.com/photo-1557862921-37829c790f19?auto=format&fit=crop&q=80&w=2671&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                            width: 100,
                            height: 100),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userModel.name ??"",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                          userModel.bio??"",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextFiled(controller: nameController, hintText: "Enter your name",isPassword: false,isForEdit: true,),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFiled(controller: emailController, hintText: "Enter your email",isPassword: false,isForEdit: true,),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFiled(controller: bioController, hintText: "Enter your bio",isPassword: false,isForEdit: true,),
                  const SizedBox(height: 50,),

                  ReusableButton(
                    title: "Update",
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    backgroundColor: Colors.blueAccent,
                    onTap: () {

                    },
                  ),
                  const SizedBox(height: 50,)
                ],
              ),
            )),
      ),
    );
  }
}
