import 'package:chat_x/api/FirebaseHelper.dart';
import 'package:chat_x/widget/user_chat_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../preference/PrefHelper.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void getProfileData() async{
    var result=await FirebaseHelper().getUserData(FirebaseAuth.instance.currentUser!.uid);
    PrefHelper.saveUserProfileData(result);
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:List.generate(20, (index) =>const UserChatCard())),
      );
  }

}
