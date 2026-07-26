import 'package:flutter/material.dart';

class CustomizedElevatedButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Gradient? gradient;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomizedElevatedButton({
    super.key,
    required this.text,
    this.color,
    this.gradient,
    this.textColor = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          fixedSize: const Size(double.infinity, 40),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
