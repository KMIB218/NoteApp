import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String hint;
  final TextEditingController cont;
  final String? Function(String?) valid;
  const CustomText(
      {super.key, required this.hint, required this.cont, required this.valid});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: valid,
      controller: cont,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
