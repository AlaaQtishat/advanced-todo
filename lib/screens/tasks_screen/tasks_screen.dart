import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/providers/theme_provider.dart';
import 'package:todo/screens/tasks_screen/widgets/add_edit_task_form.dart';
import 'package:todo/screens/tasks_screen/widgets/task_card.dart';
import 'package:todo/screens/tasks_screen/widgets/task_screen_header.dart';
import 'package:flutter/services.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    context.read<TaskProvider>().loadTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          TaskScreenHeader(),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, provider, child) {
                final activeTasks = provider.activeTasks;
                final doneTasks = provider.doneTasks;

                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 10.h,
                    bottom: 80.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (activeTasks.isNotEmpty) ...[
                        Text(
                          "ACTIVE · ${activeTasks.length}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: isDark
                                ? AppThemes.lightGrey
                                : AppThemes.darkGrey,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        ReorderableListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          buildDefaultDragHandles: false,
                          itemCount: activeTasks.length,
                          onReorder: (oldIndex, newIndex) {
                            provider.reorderTasks(
                              oldIndex,
                              newIndex,
                              activeTasks,
                            );
                          },
                          itemBuilder: (context, index) {
                            final task = activeTasks[index];
                            return TaskCard(
                              key: ValueKey(task.createdAt.toString()),

                              onEdit: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      insetPadding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 16.h,
                                      ),
                                      backgroundColor: theme.cardColor,
                                      child: AddEditTaskForm(task: task),
                                    );
                                  },
                                );
                              },
                              index: index,
                              task: task,

                              onToggleComplete: () =>
                                  provider.toggleTask(task, !task.isCompleted),
                              onPin: () => provider.togglePin(task),
                              onDelete: () {
                                provider.removeTask(task);
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                      ],

                      if (doneTasks.isNotEmpty) ...[
                        Text(
                          "DONE · ${doneTasks.length}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: isDark
                                ? AppThemes.lightGrey
                                : AppThemes.darkGrey,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        ReorderableListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          buildDefaultDragHandles: false,
                          itemCount: doneTasks.length,
                          onReorder: (oldIndex, newIndex) {
                            provider.reorderTasks(
                              oldIndex,
                              newIndex,
                              doneTasks,
                            );
                          },
                          itemBuilder: (context, index) {
                            final task = doneTasks[index];
                            return TaskCard(
                              key: ValueKey(task.createdAt.toString()),
                              onEdit: null,
                              index: index,
                              task: task,
                              onToggleComplete: () =>
                                  provider.toggleTask(task, !task.isCompleted),
                              onPin: null,
                              onDelete: () => provider.removeTask(task),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
