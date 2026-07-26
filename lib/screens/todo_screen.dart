import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/providers/theme_provider.dart';
import 'package:todo/core/widgets/filter_bar_widget.dart';
import 'package:todo/core/widgets/task_tile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController taskController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 200,
              child: Image.asset(
                "assets/images/background.jpg",
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
              top: 50,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "To Do",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                        ),
                        icon: Icon(
                          themeProvider.isDarkMode
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          size: 28,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          themeProvider.toggleTheme();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            Positioned(
              top: 170,
              left: 24,
              right: 24,
              bottom: 24,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      onSubmitted: (value) {
                        if (value.trim().isEmpty) return;

                        context.read<TaskProvider>().addTask(value);
                        taskController.clear();
                      },
                      controller: taskController,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: "Add a new task...",
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (taskController.text.trim().isEmpty) return;

                            context.read<TaskProvider>().addTask(
                              taskController.text,
                            );
                            taskController.clear();
                          },

                          icon: Icon(
                            Icons.add,
                            color: context.read<ThemeProvider>().isDarkMode
                                ? Colors.white70
                                : Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: Consumer<TaskProvider>(
                      builder: (context, taskProvider, child) {
                        final displayTasks = taskProvider.displayTasks;

                        return Column(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 24,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 12),
                                  padding: EdgeInsets.zero,
                                  itemCount: displayTasks.length,
                                  itemBuilder: (context, index) {
                                    final task = displayTasks[index];

                                    return TaskTile(
                                      title: task.taskTitle ?? "",
                                      isChecked: task.isCompleted ?? false,
                                      onDelete: () {
                                        taskProvider.removeTask(task);
                                      },
                                      onChanged: (bool newValue) {
                                        taskProvider.toggleTask(task, newValue);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              height: 48,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${displayTasks.length} Tasks results",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Theme.of(
                                              context,
                                            ).cardColor,
                                            title: const Text(
                                              "Delete Completed Tasks",
                                            ),
                                            content: const Text(
                                              "Are you sure you want to permanently delete all completed tasks?",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Cancel"),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                                onPressed: () {
                                                  taskProvider
                                                      .clearCompletedTasks();
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          "Clear Completed",
                                          style: TextStyle(
                                            letterSpacing: -0.3,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            FilterBarWidget(
                              currentFilter: taskProvider.currentFilter,
                              onFilterChanged: (newFilter) {
                                taskProvider.setFilter(newFilter);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
