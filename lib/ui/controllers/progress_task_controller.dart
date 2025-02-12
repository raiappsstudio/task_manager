import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/services/network_caller.dart';




class ProgressTaskController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMassage => _errorMessage;


  TaskListbyStatusModel? _taskListbyStatusModel;
  List<TaskModel> get tasklist => _taskListbyStatusModel?.taskList?? [];

  Future<bool> getProgressTasklist() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.listTaskListUrl('Progress'));


    if (response.isSuccess) {
      _taskListbyStatusModel = TaskListbyStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;

    } else {
      if (response.statusCode == 401) {
        _errorMessage = 'Username/Password is Incrrect';
      } else {
        _errorMessage = response.errorMessage;
      }
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
