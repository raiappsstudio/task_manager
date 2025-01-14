import 'package:task_manager/data/models/task_model.dart';

class TaskListbyStatusModel {
  String? status;
  List<TaskModel>? taskList;

  TaskListbyStatusModel({this.status, this.taskList});

  TaskListbyStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskModel>[];
      json['data'].forEach((v) {
        taskList!.add(TaskModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    if (this.taskList != null) {
      data['data'] = this.taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
