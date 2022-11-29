import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
   const CustomTextFormField({Key? key, required this.labelText, this.obscure = false,  required this.icon, required this.onChanged, required this.validator, this.hintText = "", this.controller, this.textInputType = TextInputType.text, this.prefixText = ''}) : super(key: key);

  final TextInputType textInputType;
  final String labelText;
  final String hintText;
  final String prefixText;
  final Widget icon;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;
  final bool obscure;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        keyboardType: textInputType,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          suffixIcon: icon,
          labelText: labelText,
            hintText: hintText,
            prefixText: prefixText,
            hintStyle: const TextStyle(color: Colors.grey),
            fillColor: Colors.white
        ),
        obscureText: obscure,
      ),
    );
  }
}
