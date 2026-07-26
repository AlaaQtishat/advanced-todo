import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_themes.dart';

class GradientCheckbox extends StatelessWidget {
  final bool isChecked;
  final void Function(bool)
  onChanged; // same as final ValueChanged<bool> onChanged;

  const GradientCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isChecked);
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),

          gradient: isChecked ? AppThemes.gradient : null,

          border: isChecked
              ? null
              : Border.all(color: Colors.grey.shade400, width: 2),
        ),

        child: isChecked
            ? const Icon(Icons.check, color: Colors.white, size: 18)
            : null,
      ),
    );
  }
}
