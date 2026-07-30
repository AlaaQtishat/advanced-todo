import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/widgets/customized_elevated_button.dart';

class StateFilterTab extends StatelessWidget {
  const StateFilterTab({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStatus = context.watch<TaskProvider>().statusFilter;
    return Container(
      width: double.infinity.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Color(0xFFF1F5F9),
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
                    ? Colors.white
                    : Colors.transparent,
                textColor: currentStatus == "All"
                    ? AppThemes.primaryPurple
                    : AppThemes.primaryGrey,
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
                    ? Colors.white
                    : Colors.transparent,
                textColor: currentStatus == "Active"
                    ? AppThemes.primaryPurple
                    : AppThemes.primaryGrey,
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
                    ? Colors.white
                    : Colors.transparent,
                textColor: currentStatus == "Done"
                    ? AppThemes.primaryPurple
                    : AppThemes.primaryGrey,
                isSelected: currentStatus == "Done",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
