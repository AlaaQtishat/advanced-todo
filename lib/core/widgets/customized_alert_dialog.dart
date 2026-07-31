import 'package:flutter/material.dart';

class CustomizedAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;
  final Color buttonColor;
  const CustomizedAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressed,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onPressed();
          },
          style: TextButton.styleFrom(backgroundColor: buttonColor),
          child: const Text('Yes', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
