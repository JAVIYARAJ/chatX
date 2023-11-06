import 'package:chat_x/api/FirebaseHelper.dart';
import 'package:chat_x/model/auth/UserModel.dart';
import 'package:chat_x/screens/update_profile.dart';
import 'package:chat_x/screens/updated_login.dart';
import 'package:chat_x/widget/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../preference/PrefHelper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? userModel;

  void profileData(){
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
        initialValue = 0.0;
        startValue=0.0;
        buttonValue=0.0;
        oddValue=0.0;
        evenValue=0.0;
      });
    });
  }

  final iconList = [
    Icons.account_circle,
    Icons.call,
    Icons.security,
    Icons.settings,
    Icons.help_outline_sharp,
  ];

  final iconStringList = [
    "My Account",
    "Phone",
    "Privacy",
    "Settings",
    "Help",
  ];

  double initialValue = -300.0;
  double startValue=-500;
  double buttonValue=500;

  double oddValue=-500.0;
  double evenValue=500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableProfileCard(icon: Icons.arrow_back, onTap: () {}),
                    const Text(
                      "Profile",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    ReusableProfileCard(
                        icon: Icons.edit_outlined, onTap: () {
                          Get.to(()=>const UpdateProfilePage(),transition: Transition.rightToLeft);
                    }),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  transform: Matrix4.translationValues(startValue, 0, initialValue),
                  curve: Curves.bounceInOut,
                  child: Row(
                    children: [
                      Card(
                        color: Colors.blueAccent.withAlpha(100),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(userModel?.image ??
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
                            userModel?.name ?? "",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            userModel?.bio ?? "",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: iconList.length,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            transform:index.isOdd  ?Matrix4.translationValues(oddValue, 0, 0) :Matrix4.translationValues(evenValue, 0, 0),
                            curve: Curves.easeInOut,
                            child: CustomProfileTile(
                                title: iconStringList[index],
                                icon: iconList[index],
                                onTap: () {}),
                          );
                        })),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 700),
                    transform: Matrix4.translationValues(0, buttonValue, 0),
                    curve: Curves.easeInOut,
                    child: ReusableButton(
                      title: "Logout",
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      backgroundColor: Colors.blueAccent,
                      onTap: () {
                        FirebaseHelper().logout();
                        Get.offAll(()=>const LoginPageV2(),transition:Transition.leftToRight);
                      },
                    )),
                const SizedBox(height: 50,)
              ],
            )),
      ),
    );
  }
}

class CustomProfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CustomProfileTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: ReusableProfileCard(
            icon: icon,
            onTap: onTap,
          ),
          trailing: const Icon(
            Icons.chevron_right_sharp,
            size: 35,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
