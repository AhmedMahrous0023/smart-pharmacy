import 'package:flutter/material.dart';
import 'package:smart_pharmacy/Constants/constants.dart';
import 'package:smart_pharmacy/Views/Screens/homescreen.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_text.dart';

class SuccessCheckoutScreen extends StatelessWidget {
  const SuccessCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset('images/Group3645.png'),
        ),
        Image.asset('images/Logo.png'),
         Padding(
                             padding: const EdgeInsets.all(70.0),
                             child: ElevatedButton(
                              onPressed: (){
                             Navigator.push(context,  MaterialPageRoute(builder: (context)=>HomeScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: LinearBorder(), backgroundColor:greenColor,
                                  foregroundColor: Colors.white,
                                  fixedSize: Size(MediaQuery.of(context).size.width*.80, MediaQuery.of(context).size.height*.072)),
                              child: CustomText(text: 
                                 'Thank You',color: Colors.white,fontSize: 21,fontWeight: FontWeight.bold,
                              )),
                           ),
      ],
     ),
    );
  }
}