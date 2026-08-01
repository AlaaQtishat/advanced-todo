import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/theme_provider.dart';
import 'package:todo/screens/tasks_screen/widgets/task_addition_modal.dart';

class CustomizedFloatingButton extends StatefulWidget {
  const CustomizedFloatingButton({super.key});

  @override
  State<CustomizedFloatingButton> createState() =>
      _CustomizedFloatingButtonState();
}

class _CustomizedFloatingButtonState extends State<CustomizedFloatingButton> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final theme = Theme.of(context);
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppThemes.gradient,
        boxShadow: [
          BoxShadow(
            color: isDark ? AppThemes.darkGrey : Color(0xFFC4B4FF),
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
          ),

          BoxShadow(
            color: isDark ? Colors.white24 : Color(0xFFC4B4FF),
            offset: const Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: theme.cardColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (context) {
              return const TaskAdditionModal();
            },
          );
        },
        backgroundColor: Colors.transparent,

        elevation: 0,
        highlightElevation: 0,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white, size: 28.sp),
      ),
    );
  }
}
