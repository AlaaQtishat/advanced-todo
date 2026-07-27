// import 'package:flutter/material.dart';
// import 'package:todo/core/models/task_model.dart';
// import 'package:todo/core/services/local_storage.dart';
//
// class TaskProvider extends ChangeNotifier {
//   List<TaskModel> _globalTasks = [];
//   String _currentFilter = "All";
//
//   String get currentFilter => _currentFilter;
//
//   List<TaskModel> get displayTasks {
//     if (_currentFilter == "Active") {
//       return _globalTasks.where((task) => task.isCompleted == false).toList();
//     } else if (_currentFilter == "Completed") {
//       return _globalTasks.where((task) => task.isCompleted == true).toList();
//     }
//     return _globalTasks;
//   }
//
//   Future<void> loadTasks() async {
//     _globalTasks = await LocalStorage.loadTasks();
//     notifyListeners();
//   }
//
//   void addTask(String title) {
//     _globalTasks.insert(0, TaskModel(taskTitle: title));
//     _saveAndNotify();
//   }
//
//   void removeTask(TaskModel task) {
//     _globalTasks.remove(task);
//     _saveAndNotify();
//   }
//
//   void toggleTask(TaskModel task, bool newValue) {
//     final index = _globalTasks.indexOf(task);
//
//     _globalTasks[index] = TaskModel(
//       taskTitle: task.taskTitle,
//       isCompleted: newValue,
//     );
//
//     _globalTasks.sort((a, b) {
//       if (a.isCompleted == b.isCompleted) return 0;
//       if (a.isCompleted == true) return 1;
//       return -1;
//     });
//
//     _saveAndNotify();
//   }
//
//   void clearCompletedTasks() {
//     _globalTasks.removeWhere((task) => task.isCompleted == true);
//     _saveAndNotify();
//   }
//
//   void setFilter(String newFilter) {
//     _currentFilter = newFilter;
//     notifyListeners();
//   }
//
//   void _saveAndNotify() {
//     LocalStorage.saveTasks(_globalTasks);
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:todo/core/models/task_model.dart';
import 'package:todo/core/services/local_storage.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> _globalTasks = [];
  //String _currentFilter = "All";
  String _statusFilter = "All";
  String _categoryFilter = "All";

  String get statusFilter => _statusFilter;
  String get categoryFilter => _categoryFilter;

  void setStatusFilter(String status) {
    _statusFilter = status;
    notifyListeners();
  }

  void setCategoryFilter(String category) {
    _categoryFilter = category;
    notifyListeners();
  }

  // String get currentFilter => _currentFilter;

  Future<void> loadTasks() async {
    _globalTasks = await LocalStorage.loadTasks();
    notifyListeners();
  }

  void addTask(TaskModel newTask) {
    _globalTasks.insert(0, newTask);
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
      description: task.description,
      isCompleted: newValue,
      isPinned: task.isPinned,
      priority: task.priority,
      category: task.category,
      createdAt: task.createdAt,
    );
    _saveAndNotify();
  }

  void togglePin(TaskModel task) {
    final index = _globalTasks.indexOf(task);

    _globalTasks[index] = TaskModel(
      taskTitle: task.taskTitle,
      description: task.description,
      isCompleted: task.isCompleted,
      isPinned: !task.isPinned,
      priority: task.priority,
      category: task.category,
      createdAt: task.createdAt,
    );
    _saveAndNotify();
  }

  List<TaskModel> get activeTasks {
    if (_statusFilter == "Done") return [];

    List<TaskModel> active = _globalTasks.where((task) {
      bool isActive = !task.isCompleted;
      bool matchesCategory =
          _categoryFilter == "All" || task.category == _categoryFilter;

      return isActive && matchesCategory;
    }).toList();

    active.sort((a, b) {
      if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
      return b.createdAt.compareTo(a.createdAt);
    });

    return active;
  }

  List<TaskModel> get doneTasks {
    if (_statusFilter == "Active") return [];

    List<TaskModel> done = _globalTasks.where((task) {
      bool isDone = task.isCompleted;
      bool matchesCategory =
          _categoryFilter == "All" || task.category == _categoryFilter;

      return isDone && matchesCategory;
    }).toList();

    done.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return done;
  }

  void clearCompletedTasks() {
    _globalTasks.removeWhere((task) => task.isCompleted);
    _saveAndNotify();
  }

  // void setFilter(String newFilter) {
  //   _currentFilter = newFilter;
  //   notifyListeners();
  // }

  void _saveAndNotify() {
    LocalStorage.saveTasks(_globalTasks);
    notifyListeners();
  }
}
