import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


class CustomFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller ;
  final bool isEmail; 
  final String? Function(String?)? validator; 
  const CustomFormField({
    super.key, 
    required this.hintText,
     required this.controller,
     this.isEmail=false,
     this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .049,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: BorderSide.none),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        validator: (value) {
          if (isEmail && value!.isEmpty) {
            return 'Please enter your email address.';
          } else if (isEmail && !EmailValidator.validate(value!)) {
            return 'Please enter a valid email address.';
          } else if (validator != null) {
            return validator!(value); 
          }
          return null; 
        },
      ),
    );}
}
