import 'package:flutter/material.dart';
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
        itemCount: completedTaskListbyStatusModel?.taskList?.length?? 0,
        itemBuilder: (context, index) {
          return  TaskItemWidget( taskModel: completedTaskListbyStatusModel!.taskList![index], );
        },
      ),
    );
  }


  Future<void> _getCompletedTaskList() async {
    _progressTaskInprogresber = true;
    setState(() {});

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.listTaskListUrl('Completed'));

    if (response.isSuccess) {
      completedTaskListbyStatusModel =
          TaskListbyStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBerMessage(context, response.errorMessage);
    }
    _progressTaskInprogresber = false;
    setState(() {});
  }


}
