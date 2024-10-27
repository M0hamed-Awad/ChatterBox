import 'package:flutter/material.dart';

class SnackBarCustomIcon extends StatelessWidget {
  const SnackBarCustomIcon({
    super.key,
    required this.color,
    required this.icon,
  });

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        color: color,
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
