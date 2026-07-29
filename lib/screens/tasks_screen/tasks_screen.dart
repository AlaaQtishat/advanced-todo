import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/providers/theme_provider.dart';
import 'package:todo/core/widgets/state_filter_tab.dart';
import 'package:todo/core/widgets/type_filter_tab.dart';
import 'package:todo/screens/tasks_screen/widgets/customized_floating_button.dart';
import 'package:todo/screens/tasks_screen/widgets/task_card.dart';
import 'package:intl/intl.dart';

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

  final formattedDate = DateFormat('EEE, MMMM d').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: CustomizedFloatingButton(),
        backgroundColor: Color(0xFFF8FAFC),
        body: Column(
          children: [
            Container(
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
                  SizedBox(height: 12.h),
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
                                fontSize: 20.sp,
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
                                          size: 28.sp,
                                          color: Color(0xFF62748E),
                                        )
                                      : Icon(
                                          Icons.bedtime_outlined,
                                          size: 28.sp,
                                          color: Color(0xFF62748E),
                                        ),
                                  onPressed: () {
                                    themeProvider.toggleTheme();
                                  },
                                );
                              },
                            ),
                            SizedBox(width: 8.w),
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Color(0xFFF1F5F9),
                              ),
                              icon: Icon(
                                Icons.check_box_outlined,
                                size: 28.sp,
                                color: Color(0xFF62748E),
                              ),
                              onPressed: () {},
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
                    child: TypeFilterTab(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<TaskProvider>(
                builder: (context, provider, child) {
                  final activeTasks = provider.activeTasks;
                  final doneTasks = provider.doneTasks;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
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
                              color: Colors.blueGrey.shade400,
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
                                onEdit: () => provider.updateTaskTitle(
                                  task.createdAt,
                                  task.taskTitle,
                                ),
                                index: index,
                                taskTitle: task.taskTitle,
                                description: task.description,
                                isCompleted: task.isCompleted,
                                isPinned: task.isPinned,
                                priority: task.priority,
                                category: task.category,
                                createdAt: task.createdAt,
                                dueDate: task.dueDate,
                                onToggleComplete: () => provider.toggleTask(
                                  task,
                                  !task.isCompleted,
                                ),
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
                              color: Colors.blueGrey.shade400,
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
                                onEdit: () => provider.updateTaskTitle(
                                  task.createdAt,
                                  task.taskTitle,
                                ),
                                index: index,
                                taskTitle: task.taskTitle,
                                description: task.description,
                                isCompleted: task.isCompleted,
                                isPinned: task.isPinned,
                                priority: task.priority,
                                category: task.category,
                                createdAt: task.createdAt,
                                dueDate: task.dueDate,
                                onToggleComplete: () => provider.toggleTask(
                                  task,
                                  !task.isCompleted,
                                ),
                                onPin: () => provider.togglePin(task),
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
      ),
    );
  }
}
