import 'package:flutter/material.dart';

class CustomAnimatedContainer extends StatelessWidget {
  final Matrix4 matrix;
  final Widget child;
  const CustomAnimatedContainer({super.key,required this.matrix,required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      transform: matrix,
      child: child
    );
  }
}
