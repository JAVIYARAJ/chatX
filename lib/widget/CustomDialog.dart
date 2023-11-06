import 'package:flutter/material.dart';
class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),backgroundColor: Colors.transparent,child: const Column(
      children: [
        Text("Image Provider")
      ],
    ),);
  }
}
