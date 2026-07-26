import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/models/task_model.dart';

class LocalStorage {
  static const String _storageKey = 'saved_tasks';

  static Future<void> saveTasks(List<TaskModel> tasks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> mappedList = tasks
        .map((task) => task.toJson())
        .toList();

    String tasksString = jsonEncode(mappedList);

    await prefs.setString(_storageKey, tasksString);
  }

  static Future<List<TaskModel>> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString(_storageKey);

    if (tasksString != null) {
      List<dynamic> decodedList = jsonDecode(tasksString);
      return decodedList.map((item) => TaskModel.fromJson(item)).toList();
    }

    return [];
  }
}
