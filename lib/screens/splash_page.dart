import 'package:chat_x/preference/PrefHelper.dart';
import 'package:chat_x/screens/main_page.dart';
import 'package:chat_x/screens/login_page.dart';
import 'package:chat_x/screens/updated_login.dart';
import 'package:chat_x/screens/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../util/constant.dart';
import '../widget/CustomAnimatedContainer.dart';
import '../widget/shader_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double imagePosition = -300.0; // Initial position left the screen
  double textPosition = 300.0; // Initial position right the screen

  @override
  void initState() {
    super.initState();
    // Use a delay to start the animation after the widget is built
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        imagePosition = 0.0;
        textPosition = 0.0;
      });
    });

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAll(() => const MainPage(), transition: Transition.rightToLeft);
      } else {
        if(PrefHelper.getWelcomeFlag()){
          Get.offAll(() => const LoginPageV2(), transition: Transition.rightToLeft);

        }else{
          Get.offAll(() => const WelcomePage(), transition: Transition.rightToLeft);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              CustomAnimatedContainer(
                matrix: Matrix4.translationValues(imagePosition, 0, 0),
                child: const ShaderText(
                  title: Constant.appTitle,
                  colorsList: [
                    Colors.blueAccent,
                    Colors.orange,
                    Colors.green,
                    Colors.purple,
                  ],
                  textStyle: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  isWelcomeText: false,
                ),
              ),
              CustomAnimatedContainer(
                  matrix: Matrix4.translationValues(textPosition, 0, 0),
                  child: Image.asset("assets/images/ic_chatX_icon.png"))
            ],
          ),
        ),
      ),
    );
  }
}
