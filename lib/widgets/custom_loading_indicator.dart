import 'package:chatter_box_app/constants.dart';
import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: kSecondaryColor,
      strokeWidth: 6,
    );
  }
}
