import 'package:chatter_box_app/constants.dart';
import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Color indicatorColor;
  const CustomLoadingIndicator({
    super.key,
    this.indicatorColor = kSecondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return  CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: indicatorColor,
      strokeWidth: 6,
    );
  }
}
