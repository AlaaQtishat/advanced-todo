import 'package:flutter/material.dart';
import 'package:todo/core/widgets/gradient_checkbox.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GradientCheckbox(isChecked: isChecked, onChanged: onChanged),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              decoration: isChecked ? TextDecoration.lineThrough : null,
              color: isChecked ? Colors.grey : null,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Theme.of(context).cardColor,
                  title: Text("Delete Task"),
                  content: Text(
                    "Are you sure you want to permanently delete this task?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onDelete();
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.close, color: Colors.grey.shade500, size: 24),
        ),
      ],
    );
  }
}
