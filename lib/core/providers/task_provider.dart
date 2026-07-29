import 'package:flutter/material.dart';
import 'package:todo/core/models/task_model.dart';
import 'package:todo/core/services/local_storage.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> _globalTasks = [];
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
      isPinned: false,
      priority: task.priority,
      category: task.category,
      createdAt: task.createdAt,
      dueDate: task.dueDate,
    );
    _saveAndNotify();
  }

  void updateTaskTitle(DateTime createdAt, String newTitle) {
    final index = _globalTasks.indexWhere(
      (task) => task.createdAt == createdAt,
    );
    final existingTask = _globalTasks[index];

    _globalTasks[index] = TaskModel(
      taskTitle: newTitle,
      description: existingTask.description,
      isCompleted: existingTask.isCompleted,
      isPinned: existingTask.isPinned,
      priority: existingTask.priority,
      category: existingTask.category,
      createdAt: existingTask.createdAt,
      dueDate: existingTask.dueDate,
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
      dueDate: task.dueDate,
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
      if (a.isPinned == b.isPinned) return 0;
      return a.isPinned ? -1 : 1;
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

    return done;
  }

  void clearCompletedTasks() {
    _globalTasks.removeWhere((task) => task.isCompleted);
    _saveAndNotify();
  }

  void reorderTasks(int oldIndex, int newIndex, List<TaskModel> currentList) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final tempCurrentList = List<TaskModel>.from(currentList);
    final task = tempCurrentList.removeAt(oldIndex);
    tempCurrentList.insert(newIndex, task);
    _globalTasks.remove(task);
    if (newIndex == 0) {
      _globalTasks.insert(0, task);
    } else {
      final itemBefore = tempCurrentList[newIndex - 1];
      final globalIndex = _globalTasks.indexOf(itemBefore);
      _globalTasks.insert(globalIndex + 1, task);
    }

    _saveAndNotify();
  }

  void _saveAndNotify() {
    LocalStorage.saveTasks(_globalTasks);
    notifyListeners();
  }
}
