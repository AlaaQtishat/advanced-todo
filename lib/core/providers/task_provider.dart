import 'package:flutter/material.dart';
import 'package:todo/core/models/task_model.dart';
import 'package:todo/core/services/local_storage.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> _globalTasks = [];
  String _statusFilter = "All";
  String _categoryFilter = "All";

  // Getters
  String get statusFilter => _statusFilter;
  String get categoryFilter => _categoryFilter;

  List<TaskModel> get allTasks => _globalTasks;
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

  int get totalDueSoonCount {
    return _globalTasks
        .where((task) => !task.isCompleted && isDueSoon(task.dueDate))
        .length;
  }

  int get pinnedCount => _globalTasks.where((task) => task.isPinned).length;
  int get highPriorityCount =>
      _globalTasks.where((task) => task.priority == "High").length;
  int get mediumPriorityCount =>
      _globalTasks.where((task) => task.priority == "Medium").length;
  int get lowPriorityCount =>
      _globalTasks.where((task) => task.priority == "Low").length;
  int get workCategoryCount => _globalTasks
      .where((task) => task.category == "Work" && !task.isCompleted)
      .length;
  int get personalCategoryCount => _globalTasks
      .where((task) => task.category == "Personal" && !task.isCompleted)
      .length;
  int get shoppingCategoryCount => _globalTasks
      .where((task) => task.category == "Shopping" && !task.isCompleted)
      .length;
  int get studyCategoryCount => _globalTasks
      .where((task) => task.category == "Study" && !task.isCompleted)
      .length;

  double get completionPercent {
    final allTasksCount = _globalTasks.length;
    if (allTasksCount == 0) return 0.0;

    final doneTasksTotal = _globalTasks
        .where((task) => task.isCompleted)
        .length;

    return doneTasksTotal / allTasksCount;
  }

  int get percentInt {
    return (completionPercent * 100).toInt();
  }

  double get highPriorityPercent {
    final allTasksCount = _globalTasks.length;
    if (allTasksCount == 0) return 0.0;

    return highPriorityCount / allTasksCount;
  }

  double get mediumPriorityPercent {
    final allTasksCount = _globalTasks.length;
    if (allTasksCount == 0) return 0.0;

    return mediumPriorityCount / allTasksCount;
  }

  double get lowPriorityPercent {
    final allTasksCount = _globalTasks.length;
    if (allTasksCount == 0) return 0.0;

    return lowPriorityCount / allTasksCount;
  }

  int get totalRemainingCount {
    return _globalTasks.where((task) => !task.isCompleted).length;
  }

  int get totalDoneCount {
    return _globalTasks.where((task) => task.isCompleted).length;
  }

  // Setters
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

  void clearCompletedTasks() {
    _globalTasks.removeWhere((task) => task.isCompleted);
    _saveAndNotify();
  }

  void markAllAsCompleted() {
    for (int i = 0; i < _globalTasks.length; i++) {
      if (!_globalTasks[i].isCompleted) {
        _globalTasks[i] = TaskModel(
          taskTitle: _globalTasks[i].taskTitle,
          description: _globalTasks[i].description,
          isCompleted: true,
          isPinned: _globalTasks[i].isPinned,
          priority: _globalTasks[i].priority,
          category: _globalTasks[i].category,
          createdAt: _globalTasks[i].createdAt,
          dueDate: _globalTasks[i].dueDate,
        );
      }
    }
    _saveAndNotify();
  }

  void removeTask(TaskModel task) {
    _globalTasks.removeWhere((t) => t.createdAt == task.createdAt);
    _saveAndNotify();
  }

  void toggleTask(TaskModel task, bool newValue) {
    final index = _globalTasks.indexWhere((t) => t.createdAt == task.createdAt);

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

  void togglePin(TaskModel task) {
    final index = _globalTasks.indexWhere((t) => t.createdAt == task.createdAt);

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

  bool isDueSoon(DateTime? dueDate) {
    if (dueDate == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);

    final diffDays = due.difference(today).inDays;

    return diffDays <= 3;
  }

  void reorderTasks(int oldIndex, int newIndex, List<TaskModel> currentList) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    if (oldIndex == newIndex) {
      return;
    }
    final draggedTask = currentList[oldIndex];
    final pinnedCount = currentList.where((t) => t.isPinned).length;
    if (draggedTask.isPinned) {
      if (newIndex >= pinnedCount) {
        _saveAndNotify();
        return;
      }
    } else {
      if (newIndex < pinnedCount) {
        _saveAndNotify();
        return;
      }
    }
    final tempCurrentList = List<TaskModel>.from(currentList);
    final task = tempCurrentList.removeAt(oldIndex);
    tempCurrentList.insert(newIndex, task);
    _globalTasks.removeWhere((t) => t.createdAt == task.createdAt);
    if (newIndex == 0) {
      final itemAfter = tempCurrentList[1];
      final globalIndex = _globalTasks.indexWhere(
        (t) => t.createdAt == itemAfter.createdAt,
      );
      _globalTasks.insert(globalIndex, task);
    } else {
      final itemBefore = tempCurrentList[newIndex - 1];
      final globalIndex = _globalTasks.indexWhere(
        (t) => t.createdAt == itemBefore.createdAt,
      );
      _globalTasks.insert(globalIndex + 1, task);
    }

    _saveAndNotify();
  }

  void _saveAndNotify() {
    LocalStorage.saveTasks(_globalTasks);
    notifyListeners();
  }
}
