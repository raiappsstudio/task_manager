import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/center_circular_inprogress_ber.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import '../../data/models/task_list_by_status_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_ber_messge.dart';
import '../widgets/tm_app_bar.dart';

class CancelTaskListScreen extends StatefulWidget {
  const CancelTaskListScreen({super.key});

  static const String name = '/cancel-task';

  @override
  State<CancelTaskListScreen> createState() => _CancelTaskListScreenState();
}

class _CancelTaskListScreenState extends State<CancelTaskListScreen> {
  bool _progressTaskInprogresber = false;
  TaskListbyStatusModel? cacelTaskListbyStatusModel;

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
        itemCount: cacelTaskListbyStatusModel?.taskList?.length ?? 0,
        itemBuilder: (context, index) {
          return TaskItemWidget( taskModel: cacelTaskListbyStatusModel!.taskList![index],);
        },
      ),
    );
  }

  Future<void> _getCancelTaskList() async {
    _progressTaskInprogresber = true;
    setState(() {});

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.listTaskListUrl('Cancel'));

    if (response.isSuccess) {
      cacelTaskListbyStatusModel =
          TaskListbyStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBerMessage(context, response.errorMessage);
    }
    _progressTaskInprogresber = false;
    setState(() {});
  }



}
