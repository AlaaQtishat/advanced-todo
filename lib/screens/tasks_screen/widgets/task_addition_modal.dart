import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/models/task_model.dart';
import 'package:todo/core/providers/task_provider.dart';
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

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.grey.shade300,
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
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade300),
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
                  fillColor: AppThemes.primaryGrey.withOpacity(0.1),
                  label: Text(
                    "What needs to be done?",
                    style: TextStyle(color: Colors.grey[500], fontSize: 16.sp),
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
                  fillColor: AppThemes.primaryGrey.withOpacity(0.1),
                  alignLabelWithHint: true,
                  label: Text(
                    "Add a note (optional)",
                    style: TextStyle(color: Colors.grey[500], fontSize: 16.sp),
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
                  color: Colors.black54,
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
                  color: Colors.black54,
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
            SizedBox(height: 24.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                height: 60.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFDDD6FF),
                      offset: Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: -4,
                    ),
                    BoxShadow(
                      color: Color(0xFFDDD6FF),
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
                            ),
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Task added successfully! ✅"),
                              backgroundColor: AppThemes.primaryPurple
                                  .withOpacity(0.5),
                            ),
                          );
                        }
                      : null,
                  child: Text(
                    "Add Task",
                    style: TextStyle(
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
