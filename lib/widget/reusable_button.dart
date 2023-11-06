import 'package:flutter/material.dart';
class ReusableButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color buttonColor;
  final String buttonTitle;
  final TextStyle buttonStyle;

  const ReusableButton({super.key,required this.onTap,required this.buttonColor,required this.buttonTitle,required this.buttonStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:buttonColor,
        ),
        child: Center(child: Text(buttonTitle,style: buttonStyle,),),
      ),
    );
  }
}
