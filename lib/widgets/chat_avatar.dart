import 'package:chatter_box_app/constants.dart';
import 'package:flutter/material.dart';

class ChatAvatar extends StatelessWidget {
  const ChatAvatar({
    super.key,
    required this.image,
    this.isSelected = false,
  });

  final String image;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Color borderColor = isSelected ? kPrimaryColor : Colors.white;
    double radius = isSelected ? 58 : 50;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: borderColor,
        child: CircleAvatar(
          radius: isSelected ? radius - 5 : radius - 3,
          backgroundImage: AssetImage(image),
        ),
      ),
    );
  }
}
