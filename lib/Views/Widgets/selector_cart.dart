import 'package:flutter/material.dart';
import 'package:smart_pharmacy/Constants/constants.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_text.dart';

class SelectorCart extends StatelessWidget {
  final void Function()? decrease ;
    final void Function()? incrrease ;
    final String text ;

  const SelectorCart({super.key, this.decrease, this.incrrease, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:Colors.green[300],
            child: IconButton(onPressed: decrease, icon: Icon(Icons.remove,color: Colors.white,))),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: CustomText(text: text),
          ),
                  CircleAvatar(
                    backgroundColor: Colors.green[300],
                    child: IconButton(onPressed: incrrease, icon: Icon(Icons.add,color: Colors.white,))),
      
      
        ],
      ),
    );
  }
}