import 'package:flutter/material.dart';
class ReusableAuthText extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subTitle;


  const ReusableAuthText({super.key,required this.onTap,required this.title,required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child:Align(
        alignment: Alignment.center,
        child: Text.rich(TextSpan(
            text: title,style: const TextStyle(fontSize: 15,color: Colors.white),children:[
          TextSpan(text:subTitle,style: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold))
        ])),
      ),
    );
  }
}
