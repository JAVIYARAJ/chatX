import 'package:chat_x/preference/PrefHelper.dart';
import 'package:chat_x/screens/updated_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  PageController pageController = PageController();
  int pageIndex = 0;

  var titleList=["Personalized Greetings","Instant Messaging & Video Calls","Sign in to Chat"];
  var descriptionList=["Use the user's name or any other personal information you have to create a warm and personalized welcome","App supports both text and video communication","creating an account or logging in"];

  void pageChange(int value) {
    if(titleList.length-1<value){
      skipWelcomePage();
    }else{
      pageController.jumpToPage(value);
      setState(() {
        pageIndex=value;
      });
    }

  }

  void skipWelcomePage(){
    PrefHelper.setWelcomePageFlag(true);
    Get.offAll(()=>const LoginPageV2(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 500));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged:pageChange,
                children:List.generate(titleList.length, (index) => SizedBox(height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/ic_welcome_icon${index+1}.svg"),
                      const SizedBox(height: 50,),
                      Text(titleList[index],style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                      const SizedBox(height: 50,),
                      Text(descriptionList[index],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color: Colors.black),textAlign: TextAlign.center,),
                    ],
                  ),
                )),
              ),
            ),
            SizedBox(height: 60,child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){
                  skipWelcomePage();
                }, child: const Text("Skip",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 17),)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:List.generate(titleList.length, (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 9,width: 9,decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),color:pageIndex==index ? Colors.blue : Colors.grey
                  ),
                  )),
                ),
                TextButton(onPressed: (){
                  pageChange(++pageIndex);
                }, child: const Text("Next",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent,fontSize: 17),)),
              ],
            ),),
          ],
        ),
      ),
    );
  }
}
