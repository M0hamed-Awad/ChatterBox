import 'package:chatter_box_app/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.isEnabled = true,
  });

  final String hintText;
  final bool obscureText, isEnabled;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            enabled: isEnabled,
            validator: validator != null
                ? (value) {
                    return validator!(value);
                  }
                : null,
            controller: controller,
            cursorColor: Colors.white,
            obscureText: obscureText,
            obscuringCharacter: '●',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: kTextFieldsColor,
              suffixIconColor: kPrimaryColor,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: kSubTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: _buildBorder(
                borderColor: Colors.white,
              ),
              errorBorder: _buildBorder(
                borderColor: kErrorColor,
              ),
              focusedErrorBorder: _buildBorder(
                borderColor: kErrorColor,
              ),
              errorStyle: const TextStyle(
                color: kErrorColor,
                fontSize: 16,
              ),
              errorMaxLines: 2,
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder({borderColor}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
