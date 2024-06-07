import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_pharmacy/Constants/constants.dart';
import 'package:smart_pharmacy/Core/Service/auth_service.dart';
import 'package:smart_pharmacy/Views/Screens/homescreen.dart';
import 'package:smart_pharmacy/Views/Screens/register_screen.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_formfield.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password.';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  Future<void> _handleLogin(String email, String password) async {
    
    final User? user =
        await AuthService.signInWithEmailAndPassword(email, password);
    if (user != null) {
      AuthService.saveUserLogin(true);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Check your Right Email !'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                  Center(
                      child: CustomText(
                    text: 'Welcome to Smart Pharmacy',
                    fontWeight: FontWeight.bold,
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  Center(
                      child: Image.asset(
                          'images/undraw_my_notifications_re_ehmk 1.png')),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: CustomFormField(
                      isEmail: true,
                      controller: _emailController,
                      hintText: '  Enter Your Email',
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: CustomFormField(
                      validator: validatePassword,
                      controller: _passwordController,
                      hintText: '  Enter Your Password',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Center(
                        child: TextButton(
                            onPressed: () {},
                            child: CustomText(
                              text: 'Forgot Password ?',
                              color: greenSecondery,
                              fontWeight: FontWeight.w500,
                            ))),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await _handleLogin(_emailController.text.trim(),_passwordController.text.trim());
                            } else {
                              print('Please fix the errors in the form.');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: LinearBorder(),
                              backgroundColor: greenColor,
                              foregroundColor: Colors.white,
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * .80,
                                  MediaQuery.of(context).size.height * .072)),
                          child: CustomText(
                            text: 'Sign in',
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(text: "Don't have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                  (route) => false);
                            },
                            child: CustomText(
                              text: 'Sign up',
                              color: greenSecondery,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
