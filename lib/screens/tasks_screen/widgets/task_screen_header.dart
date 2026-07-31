import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/providers/theme_provider.dart';
import 'package:todo/core/widgets/category_filter_tab.dart';
import 'package:todo/core/widgets/customized_alert_dialog.dart';
import 'package:todo/core/widgets/state_filter_tab.dart';

class TaskScreenHeader extends StatelessWidget {
  TaskScreenHeader({super.key});

  final formattedDate = DateFormat('EEE, MMMM d').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: statusBarHeight),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Tasks",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Color(0xFFF1F5F9),
                          ),
                          icon: themeProvider.isDarkMode
                              ? Icon(
                                  Icons.wb_sunny_outlined,
                                  size: 24.sp,
                                  color: AppThemes.primaryGrey,
                                )
                              : Icon(
                                  Icons.bedtime_outlined,
                                  size: 24.sp,
                                  color: AppThemes.primaryGrey,
                                ),
                          onPressed: () {
                            themeProvider.toggleTheme();
                          },
                        );
                      },
                    ),
                    SizedBox(width: 8.w),
                    PopupMenuButton<String>(
                      position: PopupMenuPosition.under,

                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),

                      onSelected: (value) {
                        if (value == 'mark_all') {
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
                        } else if (value == 'delete_done') {
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
                        }
                      },

                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'mark_all',
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: const Color(0xFF00BFA5),
                                size: 22.sp,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Mark all complete',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF2C3E50),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete_done',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline,
                                color: const Color(0xFFFF5252),
                                size: 22.sp,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Delete done (${context.read<TaskProvider>().doneTasks.length})',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF2C3E50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      child: Container(
                        padding: EdgeInsets.all(11.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_box_outlined,
                          size: 24.sp,
                          color: AppThemes.primaryGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
            child: StateFilterTab(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
            child: CategoryFilterTab(),
          ),
        ],
      ),
    );
  }
}
