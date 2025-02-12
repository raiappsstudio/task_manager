import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/controllers/completed_task_controller.dart';
import 'package:task_manager/ui/widgets/center_circular_inprogress_ber.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import '../../data/models/task_list_by_status_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_ber_messge.dart';
import '../widgets/tm_app_bar.dart';

class CompletdTaskListScreen extends StatefulWidget {
  const CompletdTaskListScreen({super.key});

  static const String name = '/completed-task';

  @override
  State<CompletdTaskListScreen> createState() => _CompletdTaskListScreenState();
}



class _CompletdTaskListScreenState extends State<CompletdTaskListScreen> {
  bool _progressTaskInprogresber = false;
  TaskListbyStatusModel? completedTaskListbyStatusModel;

  final CompletedTaskController _completedTaskController = Get.find<CompletedTaskController>();


  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: TMAppBar(),
        body: RefreshIndicator(
            onRefresh: () async{
              _getCompletedTaskList();
            },
          child: ScreenBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _builTaskListView(_completedTaskController.tasklist),
            ),
          ),
        ));
  }

  Widget _builTaskListView(List<TaskModel> taskList) {
    return GetBuilder<CompletedTaskController>(
      builder: (controll) {
        return Visibility(
          visible: controll.inProgress==false,
          replacement: CenterCirculerInprogressBer(),
          child: ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return  TaskItemWidget( taskModel: taskList[index], );
            },
          ),
        );
      }
    );
  }


  Future<void> _getCompletedTaskList() async {

    final bool isSuccess = await _completedTaskController.getCompletedTasklist();

    if (!isSuccess) {
      showSnackBerMessage(context, _completedTaskController.errorMassage!);

    } else {
    }
    _progressTaskInprogresber = false;
    setState(() {});
  }


}
