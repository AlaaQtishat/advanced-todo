import 'package:flutter/material.dart';
import 'package:todo/core/models/task_model.dart';
import 'package:todo/core/services/local_storage.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> _globalTasks = [];
  String _currentFilter = "All";

  String get currentFilter => _currentFilter;

  List<TaskModel> get displayTasks {
    if (_currentFilter == "Active") {
      return _globalTasks.where((task) => task.isCompleted == false).toList();
    } else if (_currentFilter == "Completed") {
      return _globalTasks.where((task) => task.isCompleted == true).toList();
    }
    return _globalTasks;
  }

  Future<void> loadTasks() async {
    _globalTasks = await LocalStorage.loadTasks();
    notifyListeners();
  }

  void addTask(String title) {
    _globalTasks.insert(0, TaskModel(taskTitle: title));
    _saveAndNotify();
  }

  void removeTask(TaskModel task) {
    _globalTasks.remove(task);
    _saveAndNotify();
  }

  void toggleTask(TaskModel task, bool newValue) {
    final index = _globalTasks.indexOf(task);

    _globalTasks[index] = TaskModel(
      taskTitle: task.taskTitle,
      isCompleted: newValue,
    );

    _globalTasks.sort((a, b) {
      if (a.isCompleted == b.isCompleted) return 0;
      if (a.isCompleted == true) return 1;
      return -1;
    });

    _saveAndNotify();
  }

  void clearCompletedTasks() {
    _globalTasks.removeWhere((task) => task.isCompleted == true);
    _saveAndNotify();
  }

  void setFilter(String newFilter) {
    _currentFilter = newFilter;
    notifyListeners();
  }

  void _saveAndNotify() {
    LocalStorage.saveTasks(_globalTasks);
    notifyListeners();
  }
}
