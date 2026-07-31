import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/providers/theme_provider.dart';
import 'package:todo/core/widgets/customized_alert_dialog.dart';
import 'package:todo/screens/more_screen/widgets/customized_container.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final activeTasks = context.watch<TaskProvider>().activeTasks;
    final doneTasks = context.watch<TaskProvider>().doneTasks;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          Container(
            height: 100.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: statusBarHeight),
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                    ),
                  ),
                  Text(
                    "Manage your preferences",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomizedContainer(
                      sectionTitle: "APPEARANCE",
                      child: Row(
                        children: [
                          Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color: AppThemes.primaryGrey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Icon(
                              Icons.wb_sunny_outlined,
                              size: 24.sp,
                              color: AppThemes.primaryGrey,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Theme",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Light Mode",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              overlayColor: Colors.black,

                              elevation: 0,
                              shadowColor: Colors.transparent,
                              backgroundColor: AppThemes.primaryGrey
                                  .withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            onPressed: () {
                              context.read<ThemeProvider>().toggleTheme();
                            },
                            child: Text(
                              "Switch",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppThemes.primaryPurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomizedContainer(
                      sectionTitle: "BULK ACTIONS",
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: AppThemes.primaryGreen.withOpacity(
                                    0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  size: 24.sp,
                                  color: AppThemes.primaryGreen,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mark all complete",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${activeTasks.length} tasks remaining",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  overlayColor: Colors.black,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  backgroundColor: AppThemes.primaryGreen
                                      .withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomizedAlertDialog(
                                        title: "Mark all complete",
                                        content:
                                            "Are you sure you want to mark all tasks as complete?",
                                        onPressed: () {
                                          context
                                              .read<TaskProvider>()
                                              .markAllAsCompleted();
                                        },
                                        buttonColor: AppThemes.primaryGreen,
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Run",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppThemes.primaryGreen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppThemes.primaryGrey.withOpacity(0.1),
                            height: 24.h,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: AppThemes.primaryGrey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Icon(
                                  Icons.delete_outline_rounded,
                                  size: 24.sp,
                                  color: AppThemes.highPriorityRed,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delete completed",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${doneTasks.length} tasks will be removed",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  overlayColor: Colors.black,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  backgroundColor: AppThemes.highPriorityRed
                                      .withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomizedAlertDialog(
                                        title: "Delete completed",
                                        content:
                                            "Are you sure you want to delete all completed tasks? This action cannot be undone.",
                                        onPressed: () {
                                          context
                                              .read<TaskProvider>()
                                              .clearCompletedTasks();
                                        },
                                        buttonColor: AppThemes.highPriorityRed,
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Run",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppThemes.highPriorityRed,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomizedContainer(
                      sectionTitle: "SUMMARY",
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total tasks",
                                style: TextStyle(
                                  color: AppThemes.primaryGrey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${context.read<TaskProvider>().allTasks.length}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Text(
                                "Completed tasks",
                                style: TextStyle(
                                  color: AppThemes.primaryGrey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${context.read<TaskProvider>().doneTasks.length}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Text(
                                "Active tasks",
                                style: TextStyle(
                                  color: AppThemes.primaryGrey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${context.read<TaskProvider>().activeTasks.length}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Text(
                                "Pinned tasks",
                                style: TextStyle(
                                  color: AppThemes.primaryGrey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${context.read<TaskProvider>().pinnedCount}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
