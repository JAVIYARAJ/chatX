import 'dart:typed_data';

import 'package:chat_x/api/FirebaseHelper.dart';
import 'package:chat_x/helper/AppHelper.dart';
import 'package:chat_x/screens/home_page.dart';
import 'package:chat_x/screens/login_page.dart';
import 'package:chat_x/screens/main_page.dart';
import 'package:chat_x/screens/updated_login.dart';
import 'package:chat_x/util/constant.dart';
import 'package:chat_x/validation/form_validation.dart';
import 'package:chat_x/widget/custom_text_filed.dart';
import 'package:chat_x/widget/reusable_auth_text.dart';
import 'package:chat_x/widget/reusable_button.dart';
import 'package:chat_x/widget/shader_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _bioController=TextEditingController();
  final TextEditingController _nameController=TextEditingController();
  var isLoading=false;
  Uint8List? imageFile;

  selectImage() async{
    Uint8List? file=await AppHelper.pickImage(ImageSource.gallery);
    setState(() {
      imageFile=file;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoading ? const Center(child: CircularProgressIndicator(strokeWidth: 3,),) : Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: Constant.authGradientColors,begin: Alignment.topLeft,
                  end: const Alignment(0.8, 1),
                  tileMode: TileMode.mirror
              ),
            ),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  const Align(
                    alignment: Alignment.center,
                    child: ShaderText(title: Constant.appTitle, colorsList: [
                      Colors.blueAccent,
                      Colors.orange,
                      Colors.green,
                      Colors.white,
                    ], textStyle: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.white),isWelcomeText: false,),
                  ),
                  const SizedBox(height: 50,),
                  const Text("Group chat with friends and family",style: TextStyle(fontSize: 25,color: Colors.white)),
                  const SizedBox(height: 20,),
                  Align(
                      alignment: Alignment.center,child: InkWell(
                      onTap: (){
                        selectImage();
                      },
                      child: imageFile==null ? const CircleAvatar(radius: 50,backgroundImage:AssetImage("assets/images/ic_profile_icon.png")):CircleAvatar(radius: 50,
                        backgroundImage: MemoryImage(imageFile!!),
                      ))),

                  const SizedBox(height: 50,),
                  CustomTextFiled(controller: _nameController, hintText: "Enter your name",isPassword: false,isForEdit: false,),
                  const SizedBox(height: 20,),
                  CustomTextFiled(controller: _emailController, hintText: "Enter your email",isPassword: false,isForEdit: false,),
                  const SizedBox(height: 20,),
                  CustomTextFiled(controller: _passwordController, hintText: "Enter your password",isPassword: true,isForEdit: false,),
                  const SizedBox(height: 20,),
                  CustomTextFiled(controller: _bioController, hintText: "Enter your bio",isPassword: false,isForEdit: false,),
                   const SizedBox(height: 50,),
                  Align(alignment:Alignment.center,child: ReusableButton(onTap: () async{

                    if(FormValidation.isDataValid([_emailController.text,_passwordController.text,_bioController.text,_nameController.text]) && imageFile!=null){
                      setState(() {
                        isLoading=true;
                      });
                      var result=await FirebaseHelper().userRegister(_emailController.text, _nameController.text,_passwordController.text,_bioController.text, imageFile!);
                      AppHelper.showSnackBar("Authorization",result.message,SnackPosition.BOTTOM);
                      setState(() {
                        isLoading=false;
                      });
                      if(result.status=="success"){
                          Get.offAll(()=>const MainPage(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 500));
                      }
                    }else{
                      AppHelper.showSnackBar("Authorization","Please fill all values",SnackPosition.BOTTOM);
                    }

                  }, buttonColor: Colors.blueAccent, buttonTitle: "Register", buttonStyle: const TextStyle(fontSize: 20,color: Colors.white))),
                  const SizedBox(height: 20,),
                  ReusableAuthText(onTap: (){
                    Get.offAll(()=>const LoginPageV2(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 500));
                  }, title: "Already have an account? ", subTitle: "Login")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
