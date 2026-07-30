import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/screens/tasks_screen/widgets/customized_floating_button.dart';
import 'package:todo/screens/tasks_screen/widgets/task_card.dart';
import 'package:todo/screens/tasks_screen/widgets/task_screen_header.dart';

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

  String category = "All";
  String status = "All";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: CustomizedFloatingButton(),
        backgroundColor: Color(0xFFF8FAFC),
        body: Column(
          children: [
            TaskScreenHeader(),
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
