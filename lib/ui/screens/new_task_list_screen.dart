import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
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
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [_taskSummaryStatusWidget(), _builTaskListView()],
            ),
          ),
        ));
  }

  Widget _builTaskListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const TaskItemWidget();
        },
      ),
    );
  }

  Widget _taskSummaryStatusWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            TaskStatusSummaryCounterWidget(
              title: "new",
              count: "12",
            ),
            TaskStatusSummaryCounterWidget(
              title: "Progress",
              count: "12",
            ),
            TaskStatusSummaryCounterWidget(
              title: "Completed",
              count: "12",
            ),
            TaskStatusSummaryCounterWidget(
              title: "Cancel",
              count: "12",
            ),
          ],
        ),
      ),
    );
  }
}
