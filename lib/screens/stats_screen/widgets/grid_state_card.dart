import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridStateCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;

  const GridStateCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: const Border(
          top: BorderSide(color: Color(0xFFF1F5F9), width: 1.0),
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
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 16.sp),
                SizedBox(width: 6.w),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),

          Text(
            "$count",
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
