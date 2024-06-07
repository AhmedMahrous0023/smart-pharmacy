import 'package:flutter/material.dart';
import 'package:smart_pharmacy/Constants/constants.dart';
import 'package:smart_pharmacy/Views/Screens/login_screen.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.width * .07,
              left: MediaQuery.of(context).size.width * .07,
              child: Image.asset(
                'images/logo 2.png',
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .41,
              left: MediaQuery.of(context).size.width * .34,
              child: Image.asset(
                'images/Logo.png',
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ElevatedButton(
                        onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: LinearBorder(),
                            backgroundColor: greenColor,
                            foregroundColor: Colors.white,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * .80,
                                MediaQuery.of(context).size.height * .072)),
                        child: CustomText(
                          text: 'Get Started',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ))))
          ],
        ),
      ),
    );
  }
}
