import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/providers/theme_provider.dart';
import 'package:todo/core/widgets/customized_alert_dialog.dart';
import 'package:todo/screens/tasks_screen/widgets/card_action_button.dart';

class TaskCard extends StatefulWidget {
  final int index;
  final String taskTitle;
  final String description;
  final bool isCompleted;
  final bool isPinned;
  final String priority;
  final String category;
  final DateTime createdAt;
  final VoidCallback? onToggleComplete;
  final VoidCallback? onPin;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final DateTime? dueDate;

  const TaskCard({
    super.key,
    required this.index,
    required this.taskTitle,
    required this.description,
    required this.isCompleted,
    required this.isPinned,
    required this.priority,
    required this.category,
    required this.createdAt,
    this.onToggleComplete,
    this.onPin,
    required this.onEdit,
    required this.onDelete,
    this.dueDate,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late TextEditingController _editTitleController;
  bool isEditing = false;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    _editTitleController = TextEditingController(text: widget.taskTitle);
  }

  @override
  void dispose() {
    _editTitleController.dispose();
    super.dispose();
  }

  priorityColor(String priority) {
    switch (priority) {
      case "High":
        return AppThemes.highPriorityRed;
      case "Medium":
        return AppThemes.mediumPriorityOrange;
      case "Low":
        return AppThemes.lowPriorityBlue;
      default:
        return Colors.grey;
    }
  }

  String _formatDueDate(DateTime dueDate) {
    final now = DateTime.now(); //this gives 2026-07-29 14:30:50
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    ); // this gives 2026-07-29 00:00:00
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);

    final difference = due
        .difference(today)
        .inDays; //gives for an example: Duration(days: 2)

    if (difference == 0) return "Today";
    if (difference == 1) return "Tomorrow";
    if (difference == -1) return "Yesterday";
    if (difference > 1) return "In $difference days";

    if (difference < -1) return "${difference.abs()} days ago";

    return "${dueDate.day}/${dueDate.month}";
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) return "just now";
    if (difference.inHours < 1) return "${difference.inMinutes} mins ago";

    final today = DateTime(now.year, now.month, now.day);
    final createdDay = DateTime(date.year, date.month, date.day);
    final dayDiff = today.difference(createdDay).inDays;

    if (dayDiff == 0) {
      return "${difference.inHours} hours ago";
    } else if (dayDiff == 1) {
      return "Yesterday";
    } else if (dayDiff > 1 && dayDiff <= 7) {
      return "$dayDiff days ago";
    }

    return "${date.day}/${date.month}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    return Opacity(
      opacity: widget.isCompleted ? 0.5 : 1.0,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark
                  ? AppThemes.lightGrey.withOpacity(0.05)
                  : Color(0xFFDDD6FF),
              width: 1.0,
            ),
          ),
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? AppThemes.lightGrey.withOpacity(0.05)
                  : Color(0xFFEDE9FE),
              offset: Offset(0, 1),
              blurRadius: 2.0,
              spreadRadius: -1.0,
            ),

            BoxShadow(
              color: isDark
                  ? AppThemes.lightGrey.withOpacity(0.2)
                  : Color(0xFFEDE9FE),
              offset: Offset(0, 1),
              blurRadius: 3.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: isEditing ? buildEditMode() : buildNormalMode(),
      ),
    );
  }

  Widget buildNormalMode() {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final isSoon = context.read<TaskProvider>().isDueSoon(widget.dueDate);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReorderableDragStartListener(
          index: widget.index,
          child: Padding(
            padding: EdgeInsets.only(top: 4.h, right: 12.w),
            child: Icon(
              Icons.drag_indicator,
              color: isDark
                  ? AppThemes.lightGrey.withOpacity(0.2)
                  : AppThemes.darkGrey.withOpacity(0.1),
              size: 30.sp,
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 4.h, right: 16.w),
          child: GestureDetector(
            onTap: widget.onToggleComplete,
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isCompleted
                    ? const Color(0xFF00BC7D)
                    : isDark
                    ? AppThemes.lightGrey.withOpacity(0.2)
                    : AppThemes.darkGrey.withOpacity(0.08),
              ),
              child: widget.isCompleted
                  ? Icon(Icons.check, size: 18.sp, color: Colors.white)
                  : null,
            ),
          ),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.taskTitle,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  decoration: widget.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              SizedBox(height: 12.h),

              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: widget.isCompleted
                          ? Colors.transparent
                          : priorityColor(widget.priority).withOpacity(0.1),
                      border: Border.all(color: priorityColor(widget.priority)),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8.sp,
                          color: priorityColor(widget.priority),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          widget.priority,
                          style: TextStyle(
                            color: priorityColor(widget.priority),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    widget.category,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppThemes.lightGrey : AppThemes.darkGrey,
                    ),
                  ),

                  if (widget.dueDate != null) ...[
                    Padding(
                      padding: EdgeInsets.only(top: 6.h, left: 8.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14.sp,

                            color: widget.isCompleted
                                ? Colors.grey
                                : (isSoon
                                      ? Colors.deepOrange.shade400
                                      : isDark
                                      ? AppThemes.lightGrey.withOpacity(0.5)
                                      : AppThemes.darkGrey.withOpacity(0.5)),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            _formatDueDate(widget.dueDate!),
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,

                              color: widget.isCompleted
                                  ? Colors.grey
                                  : (isSoon
                                        ? Colors.deepOrange.shade400
                                        : isDark
                                        ? AppThemes.lightGrey.withOpacity(0.5)
                                        : AppThemes.darkGrey.withOpacity(0.5)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 8.h),

              if (widget.description.isNotEmpty) ...[
                Text(
                  widget.description,

                  maxLines: isExpanded ? null : 1,
                  overflow: isExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? AppThemes.lightGrey : AppThemes.darkGrey,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8.h),
              ],
              Text(
                _formatDate(widget.createdAt),
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),

        SizedBox(width: 8.w),

        Column(
          children: [
            CardActionButton(
              icon: Icons.push_pin_outlined,
              iconColor: widget.isPinned ? AppThemes.primaryPurple : null,
              backgroundColor: widget.isPinned
                  ? AppThemes.primaryPurple.withOpacity(0.08)
                  : null,
              onTap: widget.isCompleted ? null : widget.onPin,
            ),

            SizedBox(height: 8.h),
            CardActionButton(
              icon: Icons.edit_outlined,

              onTap: widget.isCompleted
                  ? null
                  : () {
                      setState(() {
                        isEditing = true;
                      });
                      widget.onEdit();
                    },
            ),

            SizedBox(height: 8.h),

            CardActionButton(
              icon: Icons.delete_outline,

              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomizedAlertDialog(
                    title: "Delete Task",
                    content:
                        "Are you sure you want to permanently delete this task?",
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onDelete();
                    },
                    buttonColor: Colors.red,
                  ),
                );
              },
            ),

            SizedBox(height: 8.h),
            CardActionButton(
              icon: isExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildEditMode() {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReorderableDragStartListener(
          index: widget.index,
          child: Padding(
            padding: EdgeInsets.only(top: 4.h, right: 12.w),
            child: Icon(
              Icons.drag_indicator,
              color: isDark
                  ? AppThemes.lightGrey.withOpacity(0.2)
                  : AppThemes.darkGrey.withOpacity(0.1),
              size: 30.sp,
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 4.h, right: 16.w),
          child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.isCompleted
                  ? const Color(0xFF00BC7D)
                  : isDark
                  ? AppThemes.lightGrey.withOpacity(0.2)
                  : AppThemes.darkGrey.withOpacity(0.08),
            ),
          ),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _editTitleController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  filled: true,
                  fillColor: isDark
                      ? AppThemes.lightGrey.withOpacity(0.2)
                      : AppThemes.darkGrey.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 12.h),

              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<TaskProvider>().updateTaskTitle(
                        widget.createdAt,
                        _editTitleController.text.trim(),
                      );
                      setState(() {
                        isEditing = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppThemes.primaryPurple,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    icon: Icon(Icons.save_outlined, size: 18.sp),
                    label: Text(
                      "Save",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),

                  SizedBox(width: 8.w),

                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _editTitleController.text = widget.taskTitle;
                        isEditing = false;
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: isDark
                          ? AppThemes.lightGrey.withOpacity(0.2)
                          : AppThemes.darkGrey.withOpacity(0.1),
                      foregroundColor: Colors.blueGrey.shade400,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    icon: Icon(Icons.close, size: 18.sp, color: Colors.grey),
                    label: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
