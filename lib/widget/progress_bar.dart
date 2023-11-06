import 'package:flutter/material.dart';
class CustomProgressBar extends StatelessWidget {
  final bool loading;
  const CustomProgressBar({super.key,required this.loading});

  @override
  Widget build(BuildContext context) {
    return loading ? const Positioned(child: Center(child: CircularProgressIndicator(value: null,strokeWidth: 4,))) : Container();
  }
}
