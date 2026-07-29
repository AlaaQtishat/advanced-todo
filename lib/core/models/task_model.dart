class TaskModel {
  final String taskTitle;
  final String description;
  final bool isCompleted;
  final bool isPinned;
  final String priority;
  final String category;
  final DateTime createdAt;
  DateTime? dueDate;
  TaskModel({
    required this.taskTitle,
    required this.description,
    this.isCompleted = false,
    this.isPinned = false,
    required this.priority,
    required this.category,
    required this.createdAt,
    this.dueDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskTitle: json['taskTitle'] ?? '',
      description: json['description'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      isPinned: json['isPinned'] ?? false,
      priority: json['priority'] ?? 'Low',
      category: json['category'] ?? 'General',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskTitle': taskTitle,
      'description': description,
      'isCompleted': isCompleted,
      'isPinned': isPinned,
      'priority': priority,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}
