import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/controllers/cancel_task_controller.dart';
import 'package:task_manager/ui/widgets/center_circular_inprogress_ber.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import '../../data/models/task_list_by_status_model.dart';
import '../widgets/snack_ber_messge.dart';
import '../widgets/tm_app_bar.dart';

class CancelTaskListScreen extends StatefulWidget {
  const CancelTaskListScreen({super.key});

  static const String name = '/cancel-task';

  @override
  State<CancelTaskListScreen> createState() => _CancelTaskListScreenState();
}

class _CancelTaskListScreenState extends State<CancelTaskListScreen> {
  TaskListbyStatusModel? cacelTaskListbyStatusModel;

  final CancelTaskController _cancelTaskController = Get.find<CancelTaskController>();

@override
  void initState() {
    super.initState();
    _getCancelTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: TMAppBar(),
        body: RefreshIndicator(
          onRefresh: ()async{
            _getCancelTaskList();
          },
          child: ScreenBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _builTaskListView(_cancelTaskController.tasklist),
            ),
          ),
        ));
  }

  Widget _builTaskListView(List<TaskModel> taskList) {
    return GetBuilder<CancelTaskController>(
      builder: (context) {
        return Visibility(
          visible: _cancelTaskController.inProgress==false,
          replacement: CenterCirculerInprogressBer(),
          child: ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return TaskItemWidget( taskModel: taskList[index]);
            },
          ),
        );
      }
    );
  }

  Future<void> _getCancelTaskList() async {
  final bool isSuccess = await _cancelTaskController.getCancelTasklist();

    if (!isSuccess) {
      showSnackBerMessage(context, _cancelTaskController.errorMassage!);
    } else {
    }

  }



}
