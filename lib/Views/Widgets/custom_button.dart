import 'package:flutter/material.dart';
import 'package:smart_pharmacy/Constants/constants.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color color;
  final BuildContext context ;
  const CustomButton(
      {super.key, this.onPressed, required this.text,required this.color, required this.context });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: LinearBorder(), backgroundColor:Colors.amber,
            foregroundColor: Colors.white,
            fixedSize: Size(MediaQuery.of(context).size.width*.80, MediaQuery.of(context).size.height*.072)),
        child: CustomText(text: 
           text,color: Colors.white,
        ));
  }
}
