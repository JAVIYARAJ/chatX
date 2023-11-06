import 'package:flutter/material.dart';
class CustomTextFiled extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final TextStyle? hintStyle;
  final bool isPassword;
  final bool isForEdit;
  const CustomTextFiled({super.key,required this.controller,required this.hintText, this.hintStyle,required this.isPassword,required this.isForEdit});

  @override
  Widget build(BuildContext context) {

    return TextField(
      obscureText: isPassword,
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration:isForEdit ?InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ?? const TextStyle(color: Colors.black),
          border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
      ):InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ?? const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white))
      ),
    );
  }
}
