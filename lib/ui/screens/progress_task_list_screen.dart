import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/center_circular_inprogress_ber.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import '../../data/models/task_list_by_status_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
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
              child: _builTaskListView(),
            ),
          ),
        ));
  }

  Widget _builTaskListView() {
    return Visibility(
      visible: _progressTaskInprogresber==false,
      replacement: CenterCirculerInprogressBer(),
      child: ListView.builder(
        itemCount: progressTaskListbyStatusModel?.taskList?.length?? 0,
        itemBuilder: (context, index) {
          return TaskItemWidget(taskModel: progressTaskListbyStatusModel!.taskList![index]);
        },
      ),
    );
  }





  Future<void> _getProgressTaskList() async {
    _progressTaskInprogresber = true;
    setState(() {});

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.listTaskListUrl('Progress'));

    if (response.isSuccess) {
      progressTaskListbyStatusModel =
          TaskListbyStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBerMessage(context, response.errorMessage);
    }
    _progressTaskInprogresber = false;
    setState(() {});
  }



}


