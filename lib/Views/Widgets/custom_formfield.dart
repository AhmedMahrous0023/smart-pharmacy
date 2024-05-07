import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  const CustomFormField({super.key, required this.hintText});

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
      ),
    );
  }
}
