import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/providers/theme_provider.dart';
import 'package:todo/core/widgets/customized_elevated_button.dart';

class StateFilterTab extends StatelessWidget {
  const StateFilterTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final theme = Theme.of(context);
    final currentStatus = context.watch<TaskProvider>().statusFilter;
    return Container(
      width: double.infinity.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomizedElevatedButton(
                text: "All",
                fontSize: 16.sp,

                onPressed: () {
                  context.read<TaskProvider>().setStatusFilter("All");
                },
                color: currentStatus == "All"
                    ? isDark
                          ? AppThemes.primaryPurple
                          : Colors.white
                    : Colors.transparent,
                textColor: currentStatus == "All"
                    ? isDark
                          ? Colors.white
                          : AppThemes.primaryPurple
                    : (isDark ? AppThemes.lightGrey : AppThemes.darkGrey),
                isSelected: currentStatus == "All",
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomizedElevatedButton(
                text: "Active",
                fontSize: 16.sp,

                onPressed: () {
                  context.read<TaskProvider>().setStatusFilter("Active");
                },
                color: currentStatus == "Active"
                    ? isDark
                          ? AppThemes.primaryPurple
                          : Colors.white
                    : Colors.transparent,
                textColor: currentStatus == "Active"
                    ? isDark
                          ? Colors.white
                          : AppThemes.primaryPurple
                    : (isDark ? AppThemes.lightGrey : AppThemes.darkGrey),
                isSelected: currentStatus == "Active",
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomizedElevatedButton(
                text: "Done",
                fontSize: 16.sp,

                onPressed: () {
                  context.read<TaskProvider>().setStatusFilter("Done");
                },
                color: currentStatus == "Done"
                    ? isDark
                          ? AppThemes.primaryPurple
                          : Colors.white
                    : Colors.transparent,
                textColor: currentStatus == "Done"
                    ? isDark
                          ? Colors.white
                          : AppThemes.primaryPurple
                    : (isDark ? AppThemes.lightGrey : AppThemes.darkGrey),
                isSelected: currentStatus == "Done",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
