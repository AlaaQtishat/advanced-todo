import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/widgets/customized_elevated_button.dart';

class CategoryFilterTab extends StatelessWidget {
  const CategoryFilterTab({super.key});

  @override
  Widget build(BuildContext context) {
    final currentCategory = context.watch<TaskProvider>().categoryFilter;
    return SizedBox(
      height: 33.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Expanded(
            child: CustomizedElevatedButton(
              text: "🗂️ All",
              onPressed: () {
                context.read<TaskProvider>().setCategoryFilter("All");
              },
              color: currentCategory == "All" ? AppThemes.primaryPurple : null,
              textColor: currentCategory == "All" ? Colors.white : null,
              fontSize: 14.sp,
              borderColor: Colors.black26,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomizedElevatedButton(
              fontSize: 14.sp,
              text: "💼 Work",
              onPressed: () {
                context.read<TaskProvider>().setCategoryFilter("Work");
              },
              color: currentCategory == "Work"
                  ? AppThemes.primaryPurple
                  : Colors.transparent,
              borderColor: Colors.black26,
              textColor: currentCategory == "Work" ? Colors.white : null,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomizedElevatedButton(
              fontSize: 14.sp,
              text: "🏠 Personal",
              onPressed: () {
                context.read<TaskProvider>().setCategoryFilter("Personal");
              },
              color: currentCategory == "Personal"
                  ? AppThemes.primaryPurple
                  : null,
              borderColor: Colors.black26,
              textColor: currentCategory == "Personal" ? Colors.white : null,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomizedElevatedButton(
              fontSize: 14.sp,
              text: "🛒 Shopping",
              onPressed: () {
                context.read<TaskProvider>().setCategoryFilter("Shopping");
              },
              color: currentCategory == "Shopping"
                  ? AppThemes.primaryPurple
                  : null,
              borderColor: Colors.black26,
              textColor: currentCategory == "Shopping" ? Colors.white : null,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomizedElevatedButton(
              fontSize: 14.sp,
              text: "📚 Study",
              onPressed: () {
                context.read<TaskProvider>().setCategoryFilter("Study");
              },
              color: currentCategory == "Study"
                  ? AppThemes.primaryPurple
                  : Colors.transparent,
              borderColor: Colors.black26,
              textColor: currentCategory == "Study" ? Colors.white : null,
            ),
          ),
        ],
      ),
    );
  }
}
