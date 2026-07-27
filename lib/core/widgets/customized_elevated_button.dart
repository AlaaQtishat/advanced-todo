import 'package:flutter/material.dart';

class CustomizedElevatedButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final VoidCallback onPressed;
  final Color? borderColor;
  final EdgeInsets? textPadding;
  final double? fontSize;

  const CustomizedElevatedButton({
    super.key,
    required this.text,
    this.color = Colors.transparent,
    this.textColor = Colors.black54,
    required this.onPressed,
    this.borderColor = Colors.transparent,
    this.textPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //would use this shadow when the button is pressed.
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.10),
        //     offset: const Offset(0, 1),
        //     blurRadius: 2,
        //     spreadRadius: -1,
        //   ),
        //
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.10),
        //     offset: const Offset(0, 1),
        //     blurRadius: 3,
        //     spreadRadius: 0,
        //   ),
        // ],
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor!),
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
        child: Padding(
          padding: textPadding!,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
