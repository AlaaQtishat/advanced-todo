import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/constants/app_themes.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppThemes.lightGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            "$taskCount tasks",
            style: TextStyle(
              fontSize: 13.sp,
              color: AppThemes.lightGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
