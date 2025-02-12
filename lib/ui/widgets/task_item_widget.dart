import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/widgets/snack_ber_messge.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text(taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskModel.description ?? ''),
            Text(taskModel.createdDate ?? ''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: _getStatusColor(
                      taskModel.status ?? "",
                    ),
                  ),
                  child: Text(
                    taskModel.status ?? "",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        MyalerDialog(context);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {
                        UpdateStatus(context);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTask(context) async {
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.deletedTaskUrl('${taskModel.sId}'));

    if (response.isSuccess) {
      showSnackBerMessage(context, 'Delete Successfully!');
    } else {
      showSnackBerMessage(context, 'Delete Fail!');
    }
  }

  MyalerDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
              child: AlertDialog(
            title: Text('Delete!'),
            content: Text("Are you want to Delete ${taskModel.title}?"),
            actions: [
              TextButton(
                  onPressed: () {
                    _deleteTask(context);
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          ));
        });
  }

  // UpdateStatus(context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Expanded(
  //             child: AlertDialog(
  //           title: Text('Change Status!'),
  //
  //
  //
  //         ));
  //       });
  // } //Alart dialog end here================

  Color _getStatusColor(String status) {
    if (status == 'New') {
      return Colors.blue;
    } else if (status == 'Progress') {
      return Colors.deepOrangeAccent;
    } else if (status == 'Cancel') {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  void UpdateStatus(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Change Status"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('New'),
                  onTap: () {
                    _updateTaskStatus(context, "New");
                    Navigator.pop(context);
                  },
                ),
                Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text('Progress'),
                  onTap: () {
                    _updateTaskStatus(context, "Progress");
                    Navigator.pop(context);
                  },
                ),
                Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text('Completed'),
                  onTap: () {
                    _updateTaskStatus(context, "Completed");
                    Navigator.pop(context);
                  },
                ),
                Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text('Cancel'),
                  onTap: () {
                    _updateTaskStatus(context, "Cancel");
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }


  Future<void> _updateTaskStatus(BuildContext context, String status) async {
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.updateTaskStatusUrl("${taskModel.sId}",status),
    );

    if (response.isSuccess) {
      showSnackBerMessage(context, 'Update Successfully!');
    } else {
      showSnackBerMessage(context, 'Update Fail!');
    }
  }




}
