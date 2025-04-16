import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool? filled;
  final Color? fillColor;
  final TextStyle? style;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChange;
  const CustomSearch({
    super.key,
    this.suffixIcon,
    this.controller,
    required this.hintText,
    this.filled,
    this.fillColor,
    this.prefixIcon,
    this.style,
    this.onSubmitted,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      onSubmitted: onSubmitted,
      onChanged: onChange,
      style: style,
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
