import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/theme_provider.dart';

class CustomizedContainer extends StatefulWidget {
  final String sectionTitle;
  final Widget? child;
  const CustomizedContainer({
    super.key,
    required this.sectionTitle,
    this.child,
  });

  @override
  State<CustomizedContainer> createState() => _CustomizedContainerState();
}

class _CustomizedContainerState extends State<CustomizedContainer> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border(
          top: BorderSide(
            color: isDark ? theme.cardColor : Color(0xFFF1F5F9),
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            offset: const Offset(0, 1),
            blurRadius: 2.0,
            spreadRadius: -1.0,
          ),

          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            offset: const Offset(0, 1),
            blurRadius: 3.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.sectionTitle,
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey.shade600 : AppThemes.darkGrey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
