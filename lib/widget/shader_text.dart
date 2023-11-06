import 'package:flutter/material.dart';
class ShaderText extends StatelessWidget {

  final String title;
  final List<Color> colorsList;
  final TextStyle textStyle;
  final bool isWelcomeText;
  const ShaderText({super.key,required this.title,required this.colorsList,required this.textStyle,required this.isWelcomeText});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(shaderCallback: (bounds)=>LinearGradient(colors:colorsList).createShader(bounds),child:
    isWelcomeText ?Text(title,style: textStyle,textAlign: TextAlign.center,):Text(title,style: textStyle,),);
  }
}
