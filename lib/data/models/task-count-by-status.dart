import 'package:task_manager/data/models/task_count-model.dart';

class TaskCountByStatusModel {
  String? status;
  List<TaskCountModel>? taskByStatusList;

  TaskCountByStatusModel({this.status, this.taskByStatusList});

  TaskCountByStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskByStatusList = <TaskCountModel>[];
      json['data'].forEach((v) {
        taskByStatusList!.add(new TaskCountModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.taskByStatusList != null) {
      data['data'] = this.taskByStatusList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



