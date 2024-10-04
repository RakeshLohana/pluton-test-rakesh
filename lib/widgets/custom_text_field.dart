import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final String?labelText;
  final String hint;

  // Constructor with required controller, and optional keyboardType and obscureText
  const CustomTextField({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,  this.maxLines=4,  this.labelText,  required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText:labelText, // Predefined label
        border: OutlineInputBorder(), // Predefined border
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, // Custom border color when focused
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey, // Border color when not focused
            width: 1.0,
          ),
        ),
        hintText:hint ,
        contentPadding: EdgeInsets.all(15), // Padding inside the TextField
      ),
    );
  }
}
