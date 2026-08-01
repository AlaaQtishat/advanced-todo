import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/theme_provider.dart';

class GridCategoryCard extends StatelessWidget {
  final String title;
  final int taskCount;
  const GridCategoryCard({
    super.key,
    required this.title,
    required this.taskCount,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isDark
            ? AppThemes.lightGrey.withOpacity(0.1)
            : Colors.grey.withOpacity(0.09),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.grey.shade400 : AppThemes.darkGrey,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "$taskCount tasks",
            style: TextStyle(
              fontSize: 13.sp,
              color: isDark ? AppThemes.lightGrey : AppThemes.darkGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
