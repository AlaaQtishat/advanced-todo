class TaskModel {
  final String taskTitle;
  final bool? isCompleted;

  TaskModel({required this.taskTitle, this.isCompleted = false});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskTitle: json['taskTitle'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'taskTitle': taskTitle, 'isCompleted': isCompleted};
  }
}
