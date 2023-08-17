import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.controller,
    this.isObscure = false,
    required this.hint,
    this.keyboardType = TextInputType.text,
    // required this.validate
  }) : super(key: key);

  TextEditingController? controller;
  bool isObscure;

  String hint;

  // Function(String? data) validate ;

  TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      obscureText: isObscure,
      controller: controller,
      decoration: InputDecoration(
          hintText: hint,
          label: Text(
            hint,
            style: const TextStyle(color: Colors.white),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          )),
    );
  }
}
