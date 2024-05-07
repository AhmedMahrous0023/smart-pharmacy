import 'package:flutter/material.dart';
import 'package:smart_pharmacy/Constants/constants.dart';
import 'package:smart_pharmacy/Views/Screens/login_screen.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_formfield.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                Center(child: Image.asset('images/Welcome Onboard!.png')),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Center(child: Image.asset('images/Let’s help you get onboard..png'),),
                
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: CustomFormField(
                    hintText: '  Enter Your Full Name',
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: CustomFormField(
                    hintText: '  Confirm Password',
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
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                shape: LinearBorder(), backgroundColor:greenColor,
                                foregroundColor: Colors.white,
                                fixedSize: Size(MediaQuery.of(context).size.width*.80, MediaQuery.of(context).size.height*.072)),
                            child: CustomText(text: 
                               'Register',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 21,
                            )),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: "Already have an account?"),
                      TextButton(onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                      }, child: CustomText(text: 'Sign in',color: greenSecondery,))
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

