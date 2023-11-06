
import 'package:chat_x/api/FirebaseHelper.dart';
import 'package:chat_x/helper/AppHelper.dart';
import 'package:chat_x/screens/main_page.dart';
import 'package:chat_x/screens/register_page.dart';
import 'package:chat_x/util/constant.dart';
import 'package:chat_x/validation/form_validation.dart';
import 'package:chat_x/widget/custom_text_filed.dart';
import 'package:chat_x/widget/reusable_auth_text.dart';
import 'package:chat_x/widget/reusable_button.dart';
import 'package:chat_x/widget/shader_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {

    var decoration=BoxDecoration(
      gradient: LinearGradient(colors: Constant.authGradientColors,begin: Alignment.topLeft,
          end: const Alignment(0.8, 1),
          tileMode: TileMode.mirror
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoading ? const Center(child: CircularProgressIndicator(strokeWidth: 3,),) : Scaffold(
        body: Container(
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
                const SizedBox(height: 100,),
                const Text("Welcome back",style: TextStyle(fontSize: 35,color: Colors.white),),
                const SizedBox(height: 50,),
                CustomTextFiled(controller: _emailController, hintText: "Enter your email",isPassword: false,isForEdit: false,),
                const SizedBox(height: 20,),
                CustomTextFiled(controller: _passwordController, hintText: "Enter your password",isPassword: true,isForEdit: false,),
                Align(alignment: Alignment.topRight,child: TextButton(onPressed: (){},child: const Text("Forgot password?",style: TextStyle(fontSize: 15,color: Colors.white),),),),
                const SizedBox(height: 50,),
                Align(alignment:Alignment.center,child: ReusableButton(onTap: () async{

                  var isEmailValid=FormValidation.isEmailValid(_emailController.text.trim());
                  var isDataValid=FormValidation.isDataValid([_emailController.text,_passwordController.text]);
                  var isPasswordStrong=FormValidation.isPassWordStrong(_passwordController.text);

                  if(!isDataValid){
                    AppHelper.showSnackBar("Authorization", "please enter valid data",SnackPosition.BOTTOM);
                  }
                  else{
                    if(!isEmailValid){
                      AppHelper.showSnackBar("Authorization", "email is not valid",SnackPosition.BOTTOM);
                    }else if(!isPasswordStrong){
                      AppHelper.showSnackBar("Authorization", "please enter strong password",SnackPosition.BOTTOM);
                    }else{
                      setState(() {
                        isLoading=true;
                      });
                      var result=await FirebaseHelper().userLogin(_emailController.text, _passwordController.text);
                      if(result.status=="success"){
                        setState(() {
                          isLoading=false;
                        });
                        AppHelper.showSnackBar("Authorization", "Login Successfully",SnackPosition.BOTTOM);

                        Get.offAll(()=>const MainPage(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 500));
                      }else{
                        setState(() {
                          isLoading=false;
                        });
                        AppHelper.showSnackBar("Authorization", result.message,SnackPosition.BOTTOM);
                      }
                    }
                  }

                }, buttonColor: Colors.blueAccent, buttonTitle: "Login", buttonStyle: const TextStyle(fontSize: 20,color: Colors.white))),
                const SizedBox(height: 20,),
                ReusableAuthText(onTap: (){
                  Get.offAll(()=>const RegisterPage(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 500));
                }, title: "Don't have an account? ", subTitle: "Register")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
