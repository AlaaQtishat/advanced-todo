import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/models/task_model.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/providers/theme_provider.dart';
import 'package:todo/core/widgets/customized_outlined_button.dart';

class TaskAdditionModal extends StatefulWidget {
  const TaskAdditionModal({super.key});

  @override
  State<TaskAdditionModal> createState() => _TaskAdditionModalState();
}

class _TaskAdditionModalState extends State<TaskAdditionModal> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? priority;
  String? category;
  DateTime? dueDate;

  Future<void> _pickDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: AppThemes.primaryPurple),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppThemes.primaryPurple,
              ),
            ),
          ),

          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        dueDate = pickedDate;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppThemes.lightGrey.withOpacity(0.5)
                      : AppThemes.darkGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Task',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.grey),
                    style: IconButton.styleFrom(
                      side: BorderSide(color: Colors.transparent),
                      backgroundColor: isDark
                          ? Color(0xFF242426)
                          : Color(0xFFF1F5F9),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: isDark
                  ? AppThemes.lightGrey.withOpacity(0.5)
                  : AppThemes.darkGrey.withOpacity(0.3),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                controller: titleController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark ? Color(0xFF242426) : Color(0xFFF1F5F9),
                  label: Text(
                    "What needs to be done?",
                    style: TextStyle(color: Colors.grey[500], fontSize: 16.sp),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDark ? Colors.transparent : Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                controller: descriptionController,
                minLines: 2,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark ? Color(0xFF242426) : Color(0xFFF1F5F9),
                  alignLabelWithHint: true,
                  label: Text(
                    "Add a note (optional)",
                    style: TextStyle(color: Colors.grey[500], fontSize: 16.sp),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDark ? Colors.transparent : Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "PRIORITY",
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.grey.shade600 : AppThemes.darkGrey,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomizedOutlinedButton(
                      label: "High",
                      color: AppThemes.highPriorityRed,
                      isSelected: priority == "High" ? true : false,
                      onTap: () {
                        setState(() {
                          priority = "High";
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: CustomizedOutlinedButton(
                      label: "Medium",
                      color: AppThemes.mediumPriorityOrange,
                      isSelected: priority == "Medium" ? true : false,
                      onTap: () {
                        setState(() {
                          priority = "Medium";
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: CustomizedOutlinedButton(
                      label: "Low",
                      color: AppThemes.lowPriorityBlue,
                      isSelected: priority == "Low" ? true : false,
                      onTap: () {
                        setState(() {
                          priority = "Low";
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "CATEGORY",
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.grey.shade600 : AppThemes.darkGrey,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomizedOutlinedButton(
                          color: category == "Work"
                              ? AppThemes.primaryPurple
                              : Colors.grey.shade500,
                          label: "Work",
                          isSelected: category == "Work" ? true : false,
                          onTap: () {
                            setState(() {
                              category = "Work";
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomizedOutlinedButton(
                          color: category == "Personal"
                              ? AppThemes.primaryPurple
                              : Colors.grey.shade500,
                          label: "Personal",
                          isSelected: category == "Personal" ? true : false,
                          onTap: () {
                            setState(() {
                              category = "Personal";
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomizedOutlinedButton(
                          label: "Shopping",
                          color: category == "Shopping"
                              ? AppThemes.primaryPurple
                              : Colors.grey.shade500,
                          isSelected: category == "Shopping" ? true : false,

                          onTap: () {
                            setState(() {
                              category = "Shopping";
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomizedOutlinedButton(
                          label: "Study",
                          color: category == "Study"
                              ? AppThemes.primaryPurple
                              : Colors.grey.shade500,
                          isSelected: category == "Study" ? true : false,

                          onTap: () {
                            setState(() {
                              category = "Study";
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "DUE DATE (OPTIONAL)",
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.grey.shade600 : AppThemes.darkGrey,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: InkWell(
                onTap: _pickDueDate,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xFF242426) : Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDark ? Colors.transparent : Colors.grey.shade400,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey[500],
                        size: 20.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        dueDate == null
                            ? "Select a deadline"
                            : "${dueDate!.day}/${dueDate!.month}/${dueDate!.year}",
                        style: TextStyle(
                          color: dueDate == null ? Colors.grey[500] : null,
                          fontSize: 16.sp,
                          fontWeight: dueDate == null
                              ? FontWeight.normal
                              : FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (dueDate != null)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              dueDate = null;
                            });
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.grey[400],
                            size: 20.sp,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                height: 60.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? AppThemes.lightGrey.withOpacity(0.05)
                          : Color(0xFFDDD6FF),
                      offset: Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: -4,
                    ),
                    BoxShadow(
                      color: isDark
                          ? AppThemes.lightGrey.withOpacity(0.08)
                          : Color(0xFFDDD6FF),
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: -3,
                    ),
                  ],
                  gradient: AppThemes.gradient,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.grey[500],
                    disabledForegroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed:
                      (titleController.text.trim().isNotEmpty &&
                          category != null &&
                          priority != null)
                      ? () {
                          context.read<TaskProvider>().addTask(
                            TaskModel(
                              taskTitle: titleController.text,
                              description: descriptionController.text,
                              priority: priority!,
                              category: category!,
                              createdAt: DateTime.now(),
                              dueDate: dueDate,
                            ),
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Task added successfully!",
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.grey
                                      : AppThemes.darkGrey,
                                ),
                              ),
                              backgroundColor: theme.cardColor,
                            ),
                          );
                        }
                      : null,
                  child: Text(
                    "Add Task",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
