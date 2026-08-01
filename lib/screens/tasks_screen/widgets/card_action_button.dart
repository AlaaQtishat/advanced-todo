import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/theme_provider.dart';

class CardActionButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const CardActionButton({
    super.key,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final bgColor =
        backgroundColor ??
        (isDark
            ? AppThemes.lightGrey.withOpacity(0.08)
            : AppThemes.darkGrey.withOpacity(0.05));
    final iconclr = iconColor ?? (isDark ? Colors.grey : AppThemes.darkGrey);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: iconclr, size: 18.sp),
      ),
    );
  }
}
