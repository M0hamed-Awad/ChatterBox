import 'package:chatter_box_app/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.onSubmitted,
    required this.controller,
    this.suffixIcon = const SizedBox(),
  });

  final TextEditingController controller;
  final Widget suffixIcon;
  final String hintText;
  final void Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      child: TextField(
        cursorColor: kSecondaryColor,
        controller: controller,
        onSubmitted: onSubmitted,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 12,
          ),
          filled: true,
          fillColor: kTextFieldsColor,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: kSubTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
          enabledBorder: _buildBorder(borderColor: Colors.white),
          focusedBorder: _buildBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder({Color borderColor = kSecondaryColor}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: borderColor,
      ),
      borderRadius: BorderRadius.circular(16),
    );
  }
}
