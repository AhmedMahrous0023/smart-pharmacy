import 'package:flutter/material.dart';
import 'package:smart_pharmacy/Constants/constants.dart';
import 'package:smart_pharmacy/Views/Screens/home_screen.dart';
import 'package:smart_pharmacy/Views/Screens/register_screen.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_button.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_formfield.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('images/Design circle (1).png'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Center(child: Image.asset('images/Welcome Back !.png')),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Center(
                    child: Image.asset(
                        'images/undraw_my_notifications_re_ehmk 1.png')),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: CustomFormField(
                    hintText: '  Enter Your Email',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: CustomFormField(
                    hintText: '  Enter Your Password',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20,),
                  child:
                      Center(child: TextButton(onPressed: () {}, child: CustomText(text: 'Forgot Password ?',color: greenSecondery,fontWeight: FontWeight.w500,))),
                      
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                            onPressed: (){
                                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);

                            },
                            style: ElevatedButton.styleFrom(
                                shape: LinearBorder(), backgroundColor:greenColor,
                                foregroundColor: Colors.white,
                                fixedSize: Size(MediaQuery.of(context).size.width*.80, MediaQuery.of(context).size.height*.072)),
                            child: CustomText(text: 
                               'Sign in',color: Colors.white,fontSize: 21,fontWeight: FontWeight.bold,
                            )),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: "Don't have an account?"),
                      TextButton(onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RegisterScreen()), (route) => false);
                      }, child: CustomText(text: 'Sign up',color: greenSecondery,))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
