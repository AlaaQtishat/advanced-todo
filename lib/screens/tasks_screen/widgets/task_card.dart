import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/models/task_model.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/providers/theme_provider.dart';
import 'package:todo/core/widgets/customized_alert_dialog.dart';
import 'package:todo/screens/tasks_screen/widgets/card_action_button.dart';

class TaskCard extends StatefulWidget {
  final int index;
  final VoidCallback onToggleComplete;
  final VoidCallback? onPin;
  final VoidCallback? onEdit;
  final VoidCallback onDelete;
  final TaskModel task;

  const TaskCard({
    super.key,
    required this.index,
    required this.onToggleComplete,
    this.onPin,
    this.onEdit,
    required this.onDelete,
    required this.task,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isExpanded = false;

  Color priorityColor(String priority) {
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
    final isSoon = context.read<TaskProvider>().isDueSoon(widget.task.dueDate);
    return Opacity(
      opacity: widget.task.isCompleted ? 0.5 : 1.0,
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
        child: Row(
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
                    color: widget.task.isCompleted
                        ? const Color(0xFF00BC7D)
                        : isDark
                        ? AppThemes.lightGrey.withOpacity(0.2)
                        : AppThemes.darkGrey.withOpacity(0.08),
                  ),
                  child: widget.task.isCompleted
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
                    widget.task.taskTitle,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      decoration: widget.task.isCompleted
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
                          color: widget.task.isCompleted
                              ? Colors.transparent
                              : priorityColor(
                                  widget.task.priority,
                                ).withOpacity(0.1),
                          border: Border.all(
                            color: priorityColor(widget.task.priority),
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 8.sp,
                              color: priorityColor(widget.task.priority),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              widget.task.priority,
                              style: TextStyle(
                                color: priorityColor(widget.task.priority),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.task.category ?? "",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppThemes.lightGrey
                              : AppThemes.darkGrey,
                        ),
                      ),

                      if (widget.task.dueDate != null) ...[
                        Padding(
                          padding: EdgeInsets.only(top: 6.h, left: 8.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 14.sp,

                                color: widget.task.isCompleted
                                    ? Colors.grey
                                    : (isSoon
                                          ? Colors.deepOrange.shade400
                                          : isDark
                                          ? AppThemes.lightGrey.withOpacity(0.5)
                                          : AppThemes.darkGrey.withOpacity(
                                              0.5,
                                            )),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                _formatDueDate(widget.task.dueDate!),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,

                                  color: widget.task.isCompleted
                                      ? Colors.grey
                                      : (isSoon
                                            ? Colors.deepOrange.shade400
                                            : isDark
                                            ? AppThemes.lightGrey.withOpacity(
                                                0.5,
                                              )
                                            : AppThemes.darkGrey.withOpacity(
                                                0.5,
                                              )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 8.h),

                  if (widget.task.description.isNotEmpty) ...[
                    Text(
                      widget.task.description,

                      maxLines: isExpanded ? null : 1,
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isDark
                            ? AppThemes.lightGrey
                            : AppThemes.darkGrey,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 8.h),
                  ],
                  Text(
                    _formatDate(widget.task.createdAt),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            Column(
              children: [
                CardActionButton(
                  icon: Icons.push_pin_outlined,
                  iconColor: widget.task.isPinned
                      ? AppThemes.primaryPurple
                      : null,
                  backgroundColor: widget.task.isPinned
                      ? AppThemes.primaryPurple.withOpacity(0.08)
                      : null,
                  onTap: widget.onPin,
                ),

                SizedBox(height: 8.h),
                CardActionButton(
                  icon: Icons.edit_outlined,

                  onTap: widget.onEdit,
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
                          // Navigator.pop(context);
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
                      FocusScope.of(context).unfocus();
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
