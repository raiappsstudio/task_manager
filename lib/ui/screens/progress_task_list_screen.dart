import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/widgets/center_circular_inprogress_ber.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import '../../data/models/task_list_by_status_model.dart';
import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../controllers/progress_task_controller.dart';
import '../widgets/snack_ber_messge.dart';
import '../widgets/tm_app_bar.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  static const String name = '/proggress-task';

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  bool _progressTaskInprogresber = false;

  TaskListbyStatusModel? progressTaskListbyStatusModel;
  final ProgressTaskController _progressTaskController = Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();

    _getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: TMAppBar(),
        body: RefreshIndicator(
          onRefresh: ()async{
            _getProgressTaskList();
          },
          child: ScreenBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _builTaskListView(_progressTaskController.tasklist),
            ),
          ),
        ));
  }

  Widget _builTaskListView(List<TaskModel> taskList) {
    return GetBuilder<ProgressTaskController>(
      builder: (controller) {
        return Visibility(
          visible: controller.inProgress==false,
          replacement: CenterCirculerInprogressBer(),
          child: ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return TaskItemWidget(taskModel: taskList[index]);
            },
          ),
        );
      }
    );
  }


  Future<void> _getProgressTaskList() async {
    final bool isSuccess = await _progressTaskController.getProgressTasklist();

    if (!isSuccess) {
      showSnackBerMessage(context, _progressTaskController.errorMassage!);
    } else {}
  }
}


