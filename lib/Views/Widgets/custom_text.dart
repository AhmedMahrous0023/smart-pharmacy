import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final int maxLines;
  final TextDecoration decoration ;

  const CustomText(
      {super.key,
      required this.text,
       this.fontSize=18,
       this.fontWeight=FontWeight.normal,
       this.color=Colors.black,
       this.maxLines=1,  this.decoration =TextDecoration.none
       }
       );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(decoration:decoration ,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      maxLines: maxLines,
      
    );
  }
}
