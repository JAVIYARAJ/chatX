import 'dart:typed_data';
import 'package:chat_x/screens/updated_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../api/FirebaseHelper.dart';
import '../helper/AppHelper.dart';
import '../validation/form_validation.dart';
import 'home_page.dart';
class RegisterPageV2 extends StatefulWidget {
  const RegisterPageV2({super.key});

  @override
  State<RegisterPageV2> createState() => _RegisterPageV2State();
}

class _RegisterPageV2State extends State<RegisterPageV2> {

  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _confirmPasswordController=TextEditingController();
  final TextEditingController _bioController=TextEditingController();
  final TextEditingController _nameController=TextEditingController();
  var isLoading=false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  Uint8List? imageFile;

  void passwordToggle() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void confirmPasswordToggle(){
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }

  void loaderToggle() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  selectImage() async{
    Uint8List? file=await AppHelper.pickImage(ImageSource.gallery);
    setState(() {
      imageFile=file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Color.fromARGB(
                255,
                15,
                10,
                62,
              )),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 750,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Let's register",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Group chat with friends and family",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20
                      ),
                      InkWell(
                      onTap: (){
                        selectImage();
                      },
                      child: imageFile==null ? const CircleAvatar(radius: 50,backgroundImage:AssetImage("assets/images/ic_profile_icon.png")):CircleAvatar(radius: 50,
                        backgroundImage: MemoryImage(imageFile!!),
                      )),
                      const SizedBox(
                          height: 20
                      ),
                      TextField(
                          obscureText: false,
                          controller: _nameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              hintText: "Enter your name",
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black)))),
                      const SizedBox(
                        height: 20,
                      ),

                      TextField(
                          obscureText: false,
                          controller: _emailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              hintText: "Enter your email",
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black)))),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                          obscureText: isPasswordVisible,
                          controller: _passwordController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    passwordToggle();
                                  },
                                  icon: isPasswordVisible
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(
                                      Icons.remove_red_eye_outlined)),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              hintText: "Enter your password",
                              hintStyle: const TextStyle(color: Colors.black),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black)))),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                          obscureText: isPasswordVisible,
                          controller: _confirmPasswordController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    passwordToggle();
                                  },
                                  icon: isPasswordVisible
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(
                                      Icons.remove_red_eye_outlined)),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              hintText: "Enter your confirm password",
                              hintStyle: const TextStyle(color: Colors.black),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black)))),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                          obscureText: false,
                          controller: _bioController,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Enter your bio",
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black)))),

                      const Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () async{
                          if(FormValidation.isDataValid([_emailController.text,_passwordController.text,_confirmPasswordController.text,_bioController.text,_nameController.text]) && imageFile!=null){


                            if(_passwordController.text==_confirmPasswordController.text){
                              setState(() {
                                isLoading=true;
                              });
                              var result=await FirebaseHelper().userRegister(_emailController.text, _nameController.text,_passwordController.text,_bioController.text, imageFile!);
                              AppHelper.showSnackBar("Authorization",result.message,SnackPosition.BOTTOM);
                              setState(() {
                                isLoading=false;
                              });
                              if(result.status=="success"){
                                Get.offAll(()=>const HomePage(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 500));
                              }
                            }else{
                              AppHelper.showSnackBar("Authorization","password not match",SnackPosition.BOTTOM);
                            }


                          }else{
                            AppHelper.showSnackBar("Authorization","Please fill all values",SnackPosition.BOTTOM);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent,
                          ),
                          child: Center(
                            child: isLoading
                                ? const CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            )
                                : const Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account ? ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                      TextButton(onPressed: (){
                        Get.offAll(()=>const LoginPageV2(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 500));
                      }, child: const Text(
                        "Login now",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent),
                      ))

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
