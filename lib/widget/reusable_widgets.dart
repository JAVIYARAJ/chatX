import 'package:flutter/material.dart';
class ReusableProfileCard extends StatelessWidget {

  final VoidCallback onTap;
  final IconData icon;

  const ReusableProfileCard({super.key,required this.icon,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: Colors.grey.withOpacity(0.2),
        shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
        child:  Icon(
          icon,
          size: 50,
          color: Colors.deepPurpleAccent.withOpacity(0.5),
        ),
      ),
    );
  }
}

class ReusableButton extends StatelessWidget {
  final String title;
  final TextStyle style;
  final VoidCallback onTap;
  final Color backgroundColor;
  const ReusableButton({super.key,required this.title,required this.style,required this.backgroundColor,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10)
        ),
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text(title,style: style,),
        ),
      ),
    );
  }
}
