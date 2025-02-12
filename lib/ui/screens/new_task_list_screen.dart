import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task-count-by-status.dart';
import 'package:task_manager/data/models/task_count-model.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/center_circular_inprogress_ber.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_ber_messge.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import '../widgets/task_status_summary_counter_widget.dart';
import '../widgets/tm_app_bar.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  static const String name = '/new-task';

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  bool _getTaskCountbyStatusInprogress = false;
  TaskCountByStatusModel? taskCountByStatusModel;
  TaskListbyStatusModel? newTaskListbyStatusModel;

  final NewTaskController _newTaskController = Get.find<NewTaskController>();

  @override
  void initState() {
    super.initState();
    _getTaskCountByStatus();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: TMAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddNewTaskScreen.name);
          },
          child: const Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _getTaskCountByStatus();
            _getNewTaskList();
          },
          child: ScreenBackground(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _taskSummaryStatusWidget(),
                  _builTaskListView(_newTaskController.tasklist)],
              ),
            ),
          ),
        ));
  }



  Widget _builTaskListView(List<TaskModel> taskList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GetBuilder<NewTaskController>(builder: (controller) {
        return Visibility(
          visible: controller.inProgress == false,
          replacement: CenterCirculerInprogressBer(),
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return TaskItemWidget(taskModel: taskList[index]);
            },
          ),
        );
      }),
    );
  }

  Widget _taskSummaryStatusWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 120,
          child: Visibility(
            visible: _getTaskCountbyStatusInprogress == false,
            replacement: CenterCirculerInprogressBer(),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                primary: false,
                shrinkWrap: true,
                itemCount:
                    taskCountByStatusModel?.taskByStatusList?.length ?? 0,
                itemBuilder: (context, index) {
                  final TaskCountModel model =
                      taskCountByStatusModel!.taskByStatusList![index];
                  return TaskStatusSummaryCounterWidget(
                    title: model.sId ?? '',
                    count: model.sum.toString(),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Future<void> _getNewTaskList() async {
    final bool isSuccess = await _newTaskController.getNewTasklist();

    if (!isSuccess) {
      showSnackBerMessage(context, _newTaskController.errorMassage!);
    } else {}
  }

  Future<void> _getTaskCountByStatus() async {
    _getTaskCountbyStatusInprogress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskCountByStatusUrl);

    if (response.isSuccess) {
      taskCountByStatusModel =
          TaskCountByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBerMessage(context, response.errorMessage);
    }
    _getTaskCountbyStatusInprogress = false;
    setState(() {});
  }
}
