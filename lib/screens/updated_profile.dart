import 'package:chat_x/screens/updated_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/FirebaseHelper.dart';
import '../model/auth/UserModel.dart';
import '../preference/PrefHelper.dart';

class ProfilePageV2 extends StatefulWidget {
  const ProfilePageV2({super.key});

  @override
  State<ProfilePageV2> createState() => _ProfilePageV2State();
}

class _ProfilePageV2State extends State<ProfilePageV2> {
  List<Color> colors = [
    Colors.red.withAlpha(180),
    Colors.deepPurple.withAlpha(180),
    Colors.orange.withAlpha(180),
    Colors.blue.withAlpha(180),
    Colors.green.withAlpha(180),
    Colors.purple.withAlpha(180)
  ];

  List<IconData> icons = [
    Icons.account_circle,
    Icons.call,
    Icons.security,
    Icons.settings,
    Icons.help_outline_sharp,
    Icons.login
  ];

  List<String> settingList = [
    "My Account",
    "Phone",
    "Privacy",
    "Settings",
    "Help",
    "Logout"
  ];

  double oddValue = -500.0;
  double evenValue = 500;
  double imageValue = -300;

  UserModel? userModel;

  void profileData() {
    final data = PrefHelper.getUserProfileData();
    if (data != null) {
      setState(() {
        userModel = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    profileData();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        oddValue = 0.0;
        evenValue = 0.0;
        imageValue = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      transform: Matrix4.translationValues(oddValue, 0, 0),
                      curve: Curves.bounceIn,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  const Center(
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  AnimatedContainer(
                    curve: Curves.bounceInOut,
                    duration: const Duration(milliseconds: 1000),
                    transform: Matrix4.translationValues(0, imageValue, 0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(userModel?.image ??
                          "https://images.unsplash.com/photo-1557862921-37829c790f19?auto=format&fit=crop&q=80&w=2671&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    transform: Matrix4.translationValues(oddValue, 0, 0),
                    curve: Curves.bounceOut,
                    child: Text(
                      userModel?.name ?? "",
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    transform: Matrix4.translationValues(evenValue, 0, 0),
                    curve: Curves.bounceOut,
                    child: Text(
                      userModel?.bio ?? "",
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: List.generate(
                        colors.length,
                        (index) => InkWell(
                          onTap: (){
                            if(index==5){
                              FirebaseHelper().logout();
                              Get.offAll(()=>const LoginPageV2(),transition:Transition.leftToRight);
                            }
                          },
                          child: Column(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 1000),
                                    transform: index.isOdd
                                        ? Matrix4.translationValues(
                                            oddValue, 0, 0)
                                        : Matrix4.translationValues(
                                            evenValue, 0, 0),
                                    curve: Curves.easeInOut,
                                    child: ListTile(
                                      title: Text(
                                        settingList[index],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: colors[index],
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Center(
                                          child: Icon(icons[index]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
