import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/providers/theme_provider.dart';
import 'package:todo/screens/stats_screen/widgets/grid_category_card.dart';
import 'package:todo/screens/stats_screen/widgets/grid_state_card.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final theme = Theme.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final activeTasksCount = provider.totalRemainingCount;
    final doneTasksCount = provider.totalDoneCount;
    final allTasksCount = provider.allTasks.length;
    final pinnedCount = provider.pinnedCount;
    final int dueSoonCount = provider.totalDueSoonCount;
    final double completionPercent = provider.completionPercent;

    final int percentInt = provider.percentInt;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? theme.scaffoldBackgroundColor : Colors.white,
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
                    "Dashboard",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                    ),
                  ),
                  Text(
                    "Your productivity at a glance",
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 16.h,
                  bottom: 20.h,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border(
                          top: BorderSide(
                            color: isDark
                                ? AppThemes.lightGrey.withOpacity(0.05)
                                : Color(0xFFF1F5F9),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 24.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularPercentIndicator(
                              center: Text(
                                "$percentInt%",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.sp,
                                ),
                              ),
                              radius: 45.0,
                              lineWidth: 10.0,
                              percent: completionPercent,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: AppThemes.primaryPurple,
                              backgroundColor: isDark
                                  ? AppThemes.lightGrey.withOpacity(0.2)
                                  : Colors.grey.shade200,
                            ),
                            SizedBox(width: 24.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Completion rate",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8.h),

                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "$doneTasksCount",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppThemes.primaryGreen,
                                        ),
                                      ),
                                      const TextSpan(text: " done · "),
                                      TextSpan(
                                        text: "$activeTasksCount",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppThemes.primaryPurple,
                                        ),
                                      ),
                                      const TextSpan(text: " remaining"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    GridView.count(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 1.5,
                      children: [
                        GridStateCard(
                          title: "Total",
                          count: allTasksCount,
                          icon: Icons.dashboard_customize_outlined,
                          color: AppThemes.primaryPurple,
                        ),
                        GridStateCard(
                          title: "Completed",
                          count: doneTasksCount,
                          icon: Icons.check_circle_outline,
                          color: AppThemes.primaryGreen,
                        ),
                        GridStateCard(
                          title: "Remaining",
                          count: activeTasksCount,
                          icon: Icons.circle_outlined,
                          color: Colors.blueAccent,
                        ),
                        GridStateCard(
                          title: "Pinned",
                          count: pinnedCount,
                          icon: Icons.star_border_rounded,
                          color: AppThemes.mediumPriorityOrange,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border(
                          top: BorderSide(
                            color: isDark
                                ? AppThemes.lightGrey.withOpacity(0.05)
                                : Color(0xFFF1F5F9),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 20.sp,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "DUE DATES",
                                style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Container(
                                width: 12.w,
                                height: 12.w,
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange.shade400,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Due Soon",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : AppThemes.darkGrey,
                                ),
                              ),
                              Spacer(),
                              Text(
                                dueSoonCount.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18.sp,
                                  color: Colors.deepOrange.shade400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border(
                          top: BorderSide(
                            color: isDark
                                ? AppThemes.lightGrey.withOpacity(0.05)
                                : Color(0xFFF1F5F9),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.local_fire_department_outlined,
                                size: 20.sp,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "BY PRIORITY",
                                style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 65.w,
                                child: Text(
                                  "High",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                    color: isDark
                                        ? Colors.grey.shade400
                                        : AppThemes.darkGrey,
                                  ),
                                ),
                              ),

                              LinearPercentIndicator(
                                width: 250.w,
                                lineHeight: 8.0.h,
                                percent: provider.getSpecificPriorityPercent(
                                  "High",
                                ),
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                progressColor: AppThemes.highPriorityRed,
                                barRadius: Radius.circular(4.r),
                              ),
                              Spacer(),
                              Text(
                                provider
                                    .getSpecificPriorityCount("High")
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w900,
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : AppThemes.darkGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 65.w,
                                child: Text(
                                  "Medium",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                    color: isDark
                                        ? Colors.grey.shade400
                                        : AppThemes.darkGrey,
                                  ),
                                ),
                              ),

                              LinearPercentIndicator(
                                width: 250.w,
                                lineHeight: 8.0.h,
                                percent: provider.getSpecificPriorityPercent(
                                  "Medium",
                                ),
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                progressColor: AppThemes.mediumPriorityOrange,
                                barRadius: Radius.circular(4.r),
                              ),
                              Spacer(),
                              Text(
                                provider
                                    .getSpecificPriorityCount("Medium")
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w900,
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : AppThemes.darkGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              SizedBox(
                                width: 65.w,
                                child: Text(
                                  "Low",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                    color: isDark
                                        ? Colors.grey.shade400
                                        : AppThemes.darkGrey,
                                  ),
                                ),
                              ),

                              LinearPercentIndicator(
                                width: 250.w,
                                lineHeight: 8.0.h,
                                percent: provider.getSpecificPriorityPercent(
                                  "Low",
                                ),
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                progressColor: AppThemes.lowPriorityBlue,
                                barRadius: Radius.circular(4.r),
                              ),
                              Spacer(),
                              Text(
                                provider
                                    .getSpecificPriorityCount("Low")
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w900,
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : AppThemes.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border(
                          top: BorderSide(
                            color: isDark
                                ? AppThemes.lightGrey.withOpacity(0.05)
                                : Color(0xFFF1F5F9),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.category_outlined,
                                size: 20.sp,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "BY CATEGORY",
                                style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          GridView.count(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                            childAspectRatio: 2.2,
                            children: [
                              GridCategoryCard(
                                title: "Work",
                                taskCount: provider.getSpecificCategoryCount(
                                  "Work",
                                ),
                              ),
                              GridCategoryCard(
                                title: "Personal",
                                taskCount: provider.getSpecificCategoryCount(
                                  "Personal",
                                ),
                              ),
                              GridCategoryCard(
                                title: "Shopping",
                                taskCount: provider.getSpecificCategoryCount(
                                  "Shopping",
                                ),
                              ),
                              GridCategoryCard(
                                title: "Study",
                                taskCount: provider.getSpecificCategoryCount(
                                  "Study",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100.h),
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
