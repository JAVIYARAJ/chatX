import 'package:chat_x/preference/PrefHelper.dart';
import 'package:chat_x/screens/register_page.dart';
import 'package:chat_x/screens/updated_register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/FirebaseHelper.dart';
import '../helper/AppHelper.dart';
import '../util/constant.dart';
import '../validation/form_validation.dart';
import '../widget/shader_text.dart';
import 'main_page.dart';

class LoginPageV2 extends StatefulWidget {
  const LoginPageV2({super.key});

  @override
  State<LoginPageV2> createState() => _LoginPageV2State();
}

class _LoginPageV2State extends State<LoginPageV2> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isPasswordRemember = false;
  bool isLoading = false;

  void rememberPasswordToggle() {
    setState(() {
      isPasswordRemember = !isPasswordRemember;
    });
  }

  void passwordToggle() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    if (PrefHelper.getIsPasswordSaved()) {
      setState(() {
        isPasswordRemember = true;
      });
      _emailController.text = PrefHelper.getEmail() ?? "";
      _passwordController.text = PrefHelper.getPassword() ?? "";
    }else{
      setState(() {
        isPasswordRemember = false;
      });
    }
  }

  void loaderToggle() {
    setState(() {
      isLoading = !isLoading;
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ShaderText(
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
                    Image.asset("assets/images/ic_chatX_icon.png")
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 500,
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
                        "Let's sign you in",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "welcome back, you've been missed",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 50,
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
                        height: 10,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              rememberPasswordToggle();
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: isPasswordRemember
                                      ? Colors.blueAccent
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(5)),
                              child: isPasswordRemember
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.square,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Remember me",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          const Expanded(child: SizedBox()),
                          const Text(
                            "Forgot password?",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () async {
                          var isEmailValid = FormValidation.isEmailValid(
                              _emailController.text.trim());
                          var isDataValid = FormValidation.isDataValid([
                            _emailController.text,
                            _passwordController.text
                          ]);
                          var isPasswordStrong =
                              FormValidation.isPassWordStrong(
                                  _passwordController.text);

                          if (!isDataValid) {
                            AppHelper.showSnackBar(
                                "Authorization",
                                "please enter valid data",
                                SnackPosition.BOTTOM);
                          } else {
                            if (!isEmailValid) {
                              AppHelper.showSnackBar("Authorization",
                                  "email is not valid", SnackPosition.BOTTOM);
                            } else if (!isPasswordStrong) {
                              AppHelper.showSnackBar(
                                  "Authorization",
                                  "please enter strong password",
                                  SnackPosition.BOTTOM);
                            } else {
                              loaderToggle();

                              if (isPasswordRemember) {
                                PrefHelper.setEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text);
                              }else{
                                await PrefHelper.setWelcomePageFlag(false);
                              }

                              var result = await FirebaseHelper().userLogin(
                                  _emailController.text,
                                  _passwordController.text);
                              if (result.status == "success") {
                                loaderToggle();
                                AppHelper.showSnackBar("Authorization",
                                    "Login Successfully", SnackPosition.BOTTOM);

                                Get.offAll(() => const MainPage(),
                                    transition: Transition.rightToLeft,
                                    duration:
                                        const Duration(milliseconds: 500));
                              } else {
                                loaderToggle();
                                AppHelper.showSnackBar("Authorization",
                                    result.message, SnackPosition.BOTTOM);
                              }
                            }
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
                                    "Login",
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
                        "Don't have an account ? ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.offAll(() => const RegisterPageV2(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 500));
                          },
                          child: const Text(
                            "Register now",
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
