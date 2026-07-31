import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/models/task_model.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/screens/tasks_screen/widgets/task_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final allTasks = Provider.of<TaskProvider>(context).allTasks;

    List<TaskModel> searchResults = [];
    if (searchQuery.trim().isNotEmpty) {
      searchResults = allTasks.where((task) {
        final titleLower = task.taskTitle.toLowerCase();
        final queryLower = searchQuery.toLowerCase();
        return titleLower.contains(queryLower);
      }).toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          Container(
            height: 160.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: statusBarHeight),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Search",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 24.sp,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      ),
                      filled: true,
                      fillColor: AppThemes.primaryGrey.withOpacity(0.1),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      hintText: "Search tasks...",
                      contentPadding: EdgeInsets.only(
                        left: 40.w,
                        top: 16.h,
                        bottom: 16.h,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: buildBodyContent(searchResults)),
        ],
      ),
    );
  }

  Widget buildBodyContent(List<TaskModel> searchResults) {
    if (searchQuery.trim().isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          Icon(Icons.search_rounded, size: 80.sp, color: Colors.grey),
          SizedBox(height: 20.h),
          Text(
            "Type to search your tasks",
            style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          ),
          SizedBox(height: 160.h),
        ],
      );
    }

    if (searchResults.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          Icon(Icons.sentiment_dissatisfied, size: 80.sp, color: Colors.grey),
          SizedBox(height: 20.h),
          Text(
            "No tasks found for \"$searchQuery\"",
            style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          ),
          SizedBox(height: 160.h),
        ],
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(
        top: 16.h,
        left: 16.w,
        right: 16.w,
        bottom: 80.h,
      ),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final task = searchResults[index];
        return TaskCard(
          key: ValueKey(task.createdAt.toString()),
          onEdit: () => context.read<TaskProvider>().updateTaskTitle(
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
          onToggleComplete: () =>
              context.read<TaskProvider>().toggleTask(task, !task.isCompleted),
          onPin: () => context.read<TaskProvider>().togglePin(task),
          onDelete: () {
            context.read<TaskProvider>().removeTask(task);
          },
        );
      },
    );
  }
}
