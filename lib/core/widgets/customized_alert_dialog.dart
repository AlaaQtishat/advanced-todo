import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_themes.dart';

class CustomizedAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;
  final Color buttonColor;
  final String confirmationMessage;
  const CustomizedAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressed,
    required this.buttonColor,
    required this.confirmationMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.cardColor,
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppThemes.primaryGreen,
                content: Text(confirmationMessage),
              ),
            );
          },
          style: TextButton.styleFrom(backgroundColor: buttonColor),
          child: const Text('Yes', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
