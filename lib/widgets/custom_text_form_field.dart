import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String hint;
  IconData prefixIcon;
  IconData? suffixIcon;
  VoidCallback? onTapSuffixIcon;
  bool obscureText;
  bool filled;
  bool enabled;
  String? initialValue;

  TextEditingController? controller;
  Function()? onEditingComplete;
  Function(String)? onChanged;

  CustomTextFormField(
      {super.key,
      required this.hint,
      this.suffixIcon,
      this.onTapSuffixIcon,
      this.obscureText = false,
      this.onChanged,
      this.onEditingComplete,
      this.controller,
      required this.prefixIcon,
      this.filled = false,
      this.enabled = true,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        initialValue: initialValue,
        onEditingComplete: onEditingComplete,
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.red),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.black54,
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              suffixIcon,
              color: Colors.black54,
              size: 20,
            ),
            onPressed: onTapSuffixIcon,
          ),
          filled: filled,
          enabled: enabled,
        ),
      ),
    );
  }
}
