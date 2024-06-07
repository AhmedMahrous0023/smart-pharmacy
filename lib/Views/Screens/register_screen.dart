import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_pharmacy/Constants/constants.dart';
import 'package:smart_pharmacy/Core/Service/auth_service.dart';
import 'package:smart_pharmacy/Views/Screens/login_screen.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_formfield.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextEditingController _nameController =TextEditingController();
  TextEditingController _emailController =TextEditingController();
    TextEditingController _passwordController =TextEditingController();
    TextEditingController _confirmPasswordController=TextEditingController();

    String? validateFullName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your full name.';
    }
    return null; 
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password.';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null; 
  }

  String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'Please confirm your password.';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match.';
    }
    return null; 
  }

 Future<void> _handleSignUp() async {
    final bool userCreated = await AuthService.createUserWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
      _nameController.text
    );

    if (userCreated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);    } else {
      // Handle creation failure (e.g., show an error message)
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
                  Center(child: CustomText(text: 'Welcome to Smart Pharmacy',fontWeight: FontWeight.bold,),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: CustomFormField(
                      validator: validateFullName,
                      
                      controller: _nameController,
                      hintText: '  Enter Your Full Name',
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: CustomFormField(
                      isEmail: true,
                      controller: _emailController,
                      hintText: '  Enter Your Email',
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: CustomFormField(
                      validator: validatePassword,
                      controller: _passwordController,
                      hintText: '  Enter Your Password',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: CustomFormField(
                      validator: validateConfirmPassword,
                      controller: _confirmPasswordController,
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
                              onPressed: () async {
    if (_formKey.currentState!.validate()) {

      await _handleSignUp();
    } else {
      print('Please fix the errors in the form.');
    }
  },
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
      ),
    );
  }
}

