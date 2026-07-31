import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/theme_provider.dart';

class CustomizedBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomizedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final theme = Theme.of(context);
    return Container(
      height: 90.h,
      padding: EdgeInsets.only(left: 10.w, right: 10.h, top: 8.h, bottom: 4.h),
      decoration: BoxDecoration(
        color: isDark ? theme.scaffoldBackgroundColor : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavItem(
            index: 0,
            icon: Icons.check_box_outlined,
            label: 'Tasks',
          ),
          buildNavItem(index: 1, icon: Icons.search, label: 'Search'),
          buildNavItem(index: 2, icon: Icons.bar_chart_rounded, label: 'Stats'),
          buildNavItem(index: 3, icon: Icons.settings_outlined, label: 'More'),
        ],
      ),
    );
  }

  Widget buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior
          .opaque, //to make the entire area tappable, not just the icon and text
      child: Container(
        width: 90.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppThemes.lightGrey.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected)
              Container(
                width: 32.w,
                height: 3.h,
                margin: EdgeInsets.only(bottom: 4.h),
                decoration: BoxDecoration(
                  color: AppThemes.primaryPurple,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              )
            else
              SizedBox(height: 7.h),

            Icon(
              icon,
              color: isSelected
                  ? AppThemes.primaryPurple
                  : Colors.grey.shade500,
              size: 26.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? AppThemes.primaryPurple
                    : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
